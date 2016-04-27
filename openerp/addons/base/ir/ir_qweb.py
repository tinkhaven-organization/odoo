# -*- coding: utf-8 -*-
import collections
import cStringIO
import datetime
import hashlib
import json
import itertools
import logging
import math
import os
import re
import sys
import textwrap
import uuid
from subprocess import Popen, PIPE
from urlparse import urlparse

import babel
import babel.dates
import werkzeug
from lxml import etree, html
from PIL import Image
import psycopg2

import openerp.http
import openerp.tools
from openerp.tools.func import lazy_property
import openerp.tools.lru
from openerp.http import request
from openerp.tools.safe_eval import safe_eval as eval
from openerp.osv import osv, orm, fields
from openerp.tools import html_escape as escape
from openerp.tools.translate import _

_logger.warning(error)
            self.css_errors.append(error)
            return
        compiled = result[0].strip().decode('utf8')
        fragments = self.rx_css_split.split(compiled)[1:]
        while fragments:
            asset_id = fragments.pop(0)
            asset = next(asset for asset in sass if asset.id == asset_id)
            asset._content = fragments.pop(0)

    def get_sass_error(self, stderr, source=None):
        # TODO: try to find out which asset the error belongs to
        error = stderr.split('Load paths')[0].replace('  Use --trace for backtrace.', '')
        error += "This error occured while compiling the bundle '%s' containing:" % self.xmlid
        for asset in self.stylesheets:
            if isinstance(asset, SassAsset):
                error += '\n    - %s' % (asset.url if asset.url else '<inline sass>')
        return error

class WebAsset(object):
    html_url = '%s'

    def __init__(self, bundle, inline=None, url=None):
        self.id = str(uuid.uuid4())
        self.bundle = bundle
        self.inline = inline
        self.url = url
        self.cr = bundle.cr
        self.uid = bundle.uid
        self.registry = bundle.registry
        self.context = bundle.context
        self._content = None
        self._filename = None
        self._ir_attach = None
        name = '<inline asset>' if inline else url
        self.name = "%s defined in bundle '%s'" % (name, bundle.xmlid)
        if not inline and not url:
            raise Exception("An asset should either be inlined or url linked")

    def stat(self):
        if not (self.inline or self._filename or self._ir_attach):
            addon = filter(None, self.url.split('/'))[0]
            try:
                # Test url against modules static assets
                mpath = openerp.http.addons_manifest[addon]['addons_path']
                self._filename = mpath + self.url.replace('/', os.path.sep)
            except Exception:
                try:
                    # Test url against ir.attachments
                    fields = ['__last_update', 'datas', 'mimetype']
                    domain = [('type', '=', 'binary'), ('url', '=', self.url)]
                    ira = self.registry['ir.attachment']
                    attach = ira.search_read(self.cr, openerp.SUPERUSER_ID, domain, fields, context=self.context)
                    self._ir_attach = attach[0]
                except Exception:
                    raise AssetNotFound("Could not find %s" % self.name)

    def to_html(self):
        raise NotImplementedError()

    @lazy_property
    def last_modified(self):
        try:
            self.stat()
            if self._filename:
                return datetime.datetime.fromtimestamp(os.path.getmtime(self._filename))
            elif self._ir_attach:
                server_format = openerp.tools.misc.DEFAULT_SERVER_DATETIME_FORMAT
                last_update = self._ir_attach['__last_update']
                try:
                    return datetime.datetime.strptime(last_update, server_format + '.%f')
                except ValueError:
                    return datetime.datetime.strptime(last_update, server_format)
        except Exception:
            pass
        return datetime.datetime(1970, 1, 1)

    @property
    def content(self):
        if not self._content:
            self._content = self.inline or self._fetch_content()
        return self._content

    def _fetch_content(self):
        """ Fetch content from file or database"""
        try:
            self.stat()
            if self._filename:
                with open(self._filename, 'rb') as fp:
                    return fp.read().decode('utf-8')
            else:
                return self._ir_attach['datas'].decode('base64')
        except UnicodeDecodeError:
            raise AssetError('%s is not utf-8 encoded.' % self.name)
        except IOError:
            raise AssetNotFound('File %s does not exist.' % self.name)
        except:
            raise AssetError('Could not get content for %s.' % self.name)

    def minify(self):
        return self.content

    def with_header(self, content=None):
        if content is None:
            content = self.content
        return '\n/* %s */\n%s' % (self.name, content)

class JavascriptAsset(WebAsset):
    def minify(self):
        return self.with_header(rjsmin(self.content))

    def _fetch_content(self):
        try:
            return super(JavascriptAsset, self)._fetch_content()
        except AssetError, e:
            return "console.error(%s);" % json.dumps(e.message)

    def to_html(self):
        if self.url:
            return '<script type="text/javascript" src="%s"></script>' % (self.html_url % self.url)
        else:
            return '<script type="text/javascript" charset="utf-8">%s</script>' % self.with_header()

class StylesheetAsset(WebAsset):
    rx_import = re.compile(r"""@import\s+('|")(?!'|"|/|https?://)""", re.U)
    rx_url = re.compile(r"""url\s*\(\s*('|"|)(?!'|"|/|https?://|data:)""", re.U)
    rx_sourceMap = re.compile(r'(/\*# sourceMappingURL=.*)', re.U)
    rx_charset = re.compile(r'(@charset "[^"]+";)', re.U)

    def __init__(self, *args, **kw):
        self.media = kw.pop('media', None)
        super(StylesheetAsset, self).__init__(*args, **kw)

    @property
    def content(self):
        content = super(StylesheetAsset, self).content
        if self.media:
            content = '@media %s { %s }' % (self.media, content)
        return content

    def _fetch_content(self):
        try:
            content = super(StylesheetAsset, self)._fetch_content()
            web_dir = os.path.dirname(self.url)

            content = self.rx_import.sub(
                r"""@import \1%s/""" % (web_dir,),
                content,
            )

            content = self.rx_url.sub(
                r"url(\1%s/" % (web_dir,),
                content,
            )

            # remove charset declarations, we only support utf-8
            content = self.rx_charset.sub('', content)
        except AssetError, e:
            self.bundle.css_errors.append(e.message)
            return ''
        return content

    def minify(self):
        # remove existing sourcemaps, make no sense after re-mini
        content = self.rx_sourceMap.sub('', self.content)
        # comments
        content = re.sub(r'/\*.*?\*/', '', content, flags=re.S)
        # space
        content = re.sub(r'\s+', ' ', content)
        content = re.sub(r' *([{}]) *', r'\1', content)
        return self.with_header(content)

    def to_html(self):
        media = (' media="%s"' % werkzeug.utils.escape(self.media)) if self.media else ''
        if self.url:
            href = self.html_url % self.url
            return '<link rel="stylesheet" href="%s" type="text/css"%s/>' % (href, media)
        else:
            return '<style type="text/css"%s>%s</style>' % (media, self.with_header())

class SassAsset(StylesheetAsset):
    html_url = '%s.css'
    rx_indent = re.compile(r'^( +|\t+)', re.M)
    indent = None
    reindent = '    '

    def minify(self):
        return self.with_header()

    def to_html(self):
        if self.url:
            try:
                ira = self.registry['ir.attachment']
                url = self.html_url % self.url
                domain = [('type', '=', 'binary'), ('url', '=', self.url)]
                with self.cr.savepoint():
                    ira_id = ira.search(self.cr, openerp.SUPERUSER_ID, domain, context=self.context)
                    if ira_id:
                        # TODO: update only if needed
                        ira.write(self.cr, openerp.SUPERUSER_ID, [ira_id], {'datas': self.content},
                                  context=self.context)
                    else:
                        ira.create(self.cr, openerp.SUPERUSER_ID, dict(
                            datas=self.content.encode('utf8').encode('base64'),
                            mimetype='text/css',
                            type='binary',
                            name=url,
                            url=url,
                        ), context=self.context)
            except psycopg2.Error:
                pass
        return super(SassAsset, self).to_html()

    def get_source(self):
        content = textwrap.dedent(self.inline or self._fetch_content())

        def fix_indent(m):
            ind = m.group()
            if self.indent is None:
                self.indent = ind
                if self.indent == self.reindent:
                    # Don't reindent the file if identation is the final one (reindent)
                    raise StopIteration()
            return ind.replace(self.indent, self.reindent)

        try:
            content = self.rx_indent.sub(fix_indent, content)
        except StopIteration:
            pass
        return "/*! %s */\n%s" % (self.id, content)

def rjsmin(script):
    """ Minify js with a clever regex.
    Taken from http://opensource.perlig.de/rjsmin
    Apache License, Version 2.0 """
    def subber(match):
        """ Substitution callback """
        groups = match.groups()
        return (
            groups[0] or
            groups[1] or
            groups[2] or
            groups[3] or
            (groups[4] and '\n') or
            (groups[5] and ' ') or
            (groups[6] and ' ') or
            (groups[7] and ' ') or
            ''
        )

    result = re.sub(
        r'([^\047"/\000-\040]+)|((?:(?:\047[^\047\\\r\n]*(?:\\(?:[^\r\n]|\r?'
        r'\n|\r)[^\047\\\r\n]*)*\047)|(?:"[^"\\\r\n]*(?:\\(?:[^\r\n]|\r?\n|'
        r'\r)[^"\\\r\n]*)*"))[^\047"/\000-\040]*)|(?:(?<=[(,=:\[!&|?{};\r\n]'
        r')(?:[\000-\011\013\014\016-\040]|(?:/\*[^*]*\*+(?:[^/*][^*]*\*+)*/'
        r'))*((?:/(?![\r\n/*])[^/\\\[\r\n]*(?:(?:\\[^\r\n]|(?:\[[^\\\]\r\n]*'
        r'(?:\\[^\r\n][^\\\]\r\n]*)*\]))[^/\\\[\r\n]*)*/)[^\047"/\000-\040]*'
        r'))|(?:(?<=[\000-#%-,./:-@\[-^`{-~-]return)(?:[\000-\011\013\014\01'
        r'6-\040]|(?:/\*[^*]*\*+(?:[^/*][^*]*\*+)*/))*((?:/(?![\r\n/*])[^/'
        r'\\\[\r\n]*(?:(?:\\[^\r\n]|(?:\[[^\\\]\r\n]*(?:\\[^\r\n][^\\\]\r\n]'
        r'*)*\]))[^/\\\[\r\n]*)*/)[^\047"/\000-\040]*))|(?<=[^\000-!#%&(*,./'
        r':-@\[\\^`{|~])(?:[\000-\011\013\014\016-\040]|(?:/\*[^*]*\*+(?:[^/'
        r'*][^*]*\*+)*/))*(?:((?:(?://[^\r\n]*)?[\r\n]))(?:[\000-\011\013\01'
        r'4\016-\040]|(?:/\*[^*]*\*+(?:[^/*][^*]*\*+)*/))*)+(?=[^\000-\040"#'
        r'%-\047)*,./:-@\\-^`|-~])|(?<=[^\000-#%-,./:-@\[-^`{-~-])((?:[\000-'
        r'\011\013\014\016-\040]|(?:/\*[^*]*\*+(?:[^/*][^*]*\*+)*/)))+(?=[^'
        r'\000-#%-,./:-@\[-^`{-~-])|(?<=\+)((?:[\000-\011\013\014\016-\040]|'
        r'(?:/\*[^*]*\*+(?:[^/*][^*]*\*+)*/)))+(?=\+)|(?<=-)((?:[\000-\011\0'
        r'13\014\016-\040]|(?:/\*[^*]*\*+(?:[^/*][^*]*\*+)*/)))+(?=-)|(?:[\0'
        r'00-\011\013\014\016-\040]|(?:/\*[^*]*\*+(?:[^/*][^*]*\*+)*/))+|(?:'
        r'(?:(?://[^\r\n]*)?[\r\n])(?:[\000-\011\013\014\016-\040]|(?:/\*[^*'
        r']*\*+(?:[^/*][^*]*\*+)*/))*)+', subber, '\n%s\n' % script
    ).strip()
    return result

# vim:et:
