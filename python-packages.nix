{
  Babel = super.buildPythonPackage {
    name = "Babel-1.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pytz];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/B/Babel/Babel-1.3.tar.gz";
      md5 = "5264ceb02717843cbc9ffce8e6e06bdb";
    };
  };
  Jinja2 = super.buildPythonPackage {
    name = "Jinja2-2.7.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [MarkupSafe];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.7.3.tar.gz";
      md5 = "b9dffd2f3b43d673802fe857c8445b1a";
    };
  };
  Mako = super.buildPythonPackage {
    name = "Mako-1.0.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [MarkupSafe];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/M/Mako/Mako-1.0.0.tar.gz";
      md5 = "ae27c6512832fe528bb67f1a851921cc";
    };
  };
  MarkupSafe = super.buildPythonPackage {
    name = "MarkupSafe-0.23";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/M/MarkupSafe/MarkupSafe-0.23.tar.gz";
      md5 = "f5ab3deee4c37cd6a922fb81e730da6e";
    };
  };
  Pillow = super.buildPythonPackage {
    name = "Pillow-2.5.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/P/Pillow/Pillow-2.5.1.zip";
      md5 = "cf42c695fab68116af2c8ef816fca0d9";
    };
  };
  PyYAML = super.buildPythonPackage {
    name = "PyYAML-3.11";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.11.tar.gz";
      md5 = "f50e08ef0fe55178479d3a618efe21db";
    };
  };
  Python-Chart = super.buildPythonPackage {
    name = "Python-Chart-1.39";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/P/Python-Chart/Python-Chart-1.39.tar.gz";
      md5 = "e00543bcc2b34fab5054a77f311f2d17";
    };
  };
  Werkzeug = super.buildPythonPackage {
    name = "Werkzeug-0.9.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/W/Werkzeug/Werkzeug-0.9.6.tar.gz";
      md5 = "f7afcadc03b0f2267bdc156c34586043";
    };
  };
  argparse = super.buildPythonPackage {
    name = "argparse-1.2.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/a/argparse/argparse-1.2.1.tar.gz";
      md5 = "2fbef8cb61e506c706957ab6e135840c";
    };
  };
  decorator = super.buildPythonPackage {
    name = "decorator-3.4.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/d/decorator/decorator-3.4.0.tar.gz";
      md5 = "1e8756f719d746e2fc0dd28b41251356";
    };
  };
  docutils = super.buildPythonPackage {
    name = "docutils-0.12";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/d/docutils/docutils-0.12.tar.gz";
      md5 = "4622263b62c5c771c03502afa3157768";
    };
  };
  feedparser = super.buildPythonPackage {
    name = "feedparser-5.1.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/f/feedparser/feedparser-5.1.3.tar.bz2";
      md5 = "6fb6372a1dc2f56d4d79d740b8f49f25";
    };
  };
  gdata = super.buildPythonPackage {
    name = "gdata-2.0.18";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/g/gdata/gdata-2.0.18.tar.gz";
      md5 = "13b6e6dd8f9e3e9a8e005e05a8329408";
    };
  };
  gevent = super.buildPythonPackage {
    name = "gevent-1.0.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [greenlet];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/g/gevent/gevent-1.0.1.tar.gz";
      md5 = "7b952591d1a0174d6eb6ac47bd975ab6";
    };
  };
  greenlet = super.buildPythonPackage {
    name = "greenlet-0.4.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/g/greenlet/greenlet-0.4.2.zip";
      md5 = "580a8a5e833351f7abdaedb1a877f7ac";
    };
  };
  jcconv = super.buildPythonPackage {
    name = "jcconv-0.2.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/j/jcconv/jcconv-0.2.3.tar.gz";
      md5 = "b51dc04034f9aef21c955ea6d19571d9";
    };
  };
  lxml = super.buildPythonPackage {
    name = "lxml-3.3.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/l/lxml/lxml-3.3.5.tar.gz";
      md5 = "88c75f4c73fc8f59c9ebb17495044f2f";
    };
  };
  mock = super.buildPythonPackage {
    name = "mock-1.0.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/m/mock/mock-1.0.1.tar.gz";
      md5 = "c3971991738caa55ec7c356bbc154ee2";
    };
  };
  passlib = super.buildPythonPackage {
    name = "passlib-1.6.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/passlib/passlib-1.6.2.tar.gz";
      md5 = "2f872ae7c72ca338634c618f2cff5863";
    };
  };
  pip = super.buildPythonPackage {
    name = "pip-7.1.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/pip/pip-7.1.2.tar.gz";
      md5 = "3823d2343d9f3aaab21cf9c917710196";
    };
  };
  psutil = super.buildPythonPackage {
    name = "psutil-2.1.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/psutil/psutil-2.1.1.tar.gz";
      md5 = "72a6b15d589fab11f6ca245b775bc3c6";
    };
  };
  psycogreen = super.buildPythonPackage {
    name = "psycogreen-1.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/psycogreen/psycogreen-1.0.tar.gz";
      md5 = "7a32d8f5abdb4ce17ac512f8c8a698a9";
    };
  };
  psycopg2 = super.buildPythonPackage {
    name = "psycopg2-2.5.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/psycopg2/psycopg2-2.5.3.tar.gz";
      md5 = "09dcec70f623a9ef774f1aef75690995";
    };
  };
  pyPdf = super.buildPythonPackage {
    name = "pyPdf-1.13";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/pyPdf/pyPdf-1.13.tar.gz";
      md5 = "7a75ef56f227b78ae62d6e38d4b6b1da";
    };
  };
  pydot = super.buildPythonPackage {
    name = "pydot-1.0.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [pyparsing setuptools];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/pydot/pydot-1.0.2.tar.gz";
      md5 = "cd739651ae5e1063a89f7efd5a9ec72b";
    };
  };
  pyparsing = super.buildPythonPackage {
    name = "pyparsing-1.5.7";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/pyparsing/pyparsing-1.5.7.tar.gz";
      md5 = "9be0fcdcc595199c646ab317c1d9a709";
    };
  };
  pyserial = super.buildPythonPackage {
    name = "pyserial-2.7";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/pyserial/pyserial-2.7.tar.gz";
      md5 = "794506184df83ef2290de0d18803dd11";
    };
  };
  python-dateutil = super.buildPythonPackage {
    name = "python-dateutil-1.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/python-dateutil/python-dateutil-1.5.tar.gz";
      md5 = "0dcb1de5e5cad69490a3b6ab63f0cfa5";
    };
  };
  python-ldap = super.buildPythonPackage {
    name = "python-ldap-2.4.15";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [setuptools];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/python-ldap/python-ldap-2.4.15.tar.gz";
      md5 = "f12183c87579631584c4bbe2d85ad0d9";
    };
  };
  python-openid = super.buildPythonPackage {
    name = "python-openid-2.2.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/python-openid/python-openid-2.2.5.tar.gz";
      md5 = "393f48b162ec29c3de9e2973548ea50d";
    };
  };
  python-stdnum = super.buildPythonPackage {
    name = "python-stdnum-1.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/python-stdnum/python-stdnum-1.2.tar.gz";
      md5 = "286999afc3402c21024520fdf04ac498";
    };
  };
  pytz = super.buildPythonPackage {
    name = "pytz-2014.4";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/pytz/pytz-2014.4.tar.bz2";
      md5 = "69078b2e80eeb4e74c4c93089a101bcc";
    };
  };
  pyusb = super.buildPythonPackage {
    name = "pyusb-1.0.0b1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/p/pyusb/pyusb-1.0.0b1.tar.gz";
      md5 = "5cc9c7dd77b4d12fcc22fee3b39844bc";
    };
  };
  qrcode = super.buildPythonPackage {
    name = "qrcode-5.0.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [six];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/q/qrcode/qrcode-5.0.1.tar.gz";
      md5 = "bef9cccd638888724cd2ae31860875b5";
    };
  };
  reportlab = super.buildPythonPackage {
    name = "reportlab-3.1.8";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [Pillow pip setuptools];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/r/reportlab/reportlab-3.1.8.tar.gz";
      md5 = "820a9fda647078503597b85cdba7ed7f";
    };
  };
  requests = super.buildPythonPackage {
    name = "requests-2.6.0";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/r/requests/requests-2.6.0.tar.gz";
      md5 = "25287278fa3ea106207461112bb37050";
    };
  };
  setuptools = super.buildPythonPackage {
    name = "setuptools-18.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/s/setuptools/setuptools-18.5.tar.gz";
      md5 = "533c868f01169a3085177dffe5e768bb";
    };
  };
  simplejson = super.buildPythonPackage {
    name = "simplejson-3.5.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/s/simplejson/simplejson-3.5.3.tar.gz";
      md5 = "d5f62dfa6b6dea31735d56c858361d48";
    };
  };
  six = super.buildPythonPackage {
    name = "six-1.7.3";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/s/six/six-1.7.3.tar.gz";
      md5 = "784c6e5541c3c4952de9c0a966a0a80b";
    };
  };
  unittest2 = super.buildPythonPackage {
    name = "unittest2-0.5.1";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/u/unittest2/unittest2-0.5.1.tar.gz";
      md5 = "a0af5cac92bbbfa0c3b0e99571390e0f";
    };
  };
  vatnumber = super.buildPythonPackage {
    name = "vatnumber-1.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [python-stdnum];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/v/vatnumber/vatnumber-1.2.tar.gz";
      md5 = "3b1541be3834a865f6f7bcce809ffb25";
    };
  };
  vobject = super.buildPythonPackage {
    name = "vobject-0.6.6";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [python-dateutil];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/v/vobject/vobject-0.6.6.tar.gz";
      md5 = "4a57e8a819ca5477db3598e6ed12ef6f";
    };
  };
  wsgiref = super.buildPythonPackage {
    name = "wsgiref-0.1.2";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/w/wsgiref/wsgiref-0.1.2.zip";
      md5 = "29b146e6ebd0f9fb119fe321f7bcf6cb";
    };
  };
  xlwt = super.buildPythonPackage {
    name = "xlwt-0.7.5";
    buildInputs = with self; [];
    doCheck = false;
    propagatedBuildInputs = with self; [];
    src = fetchurl {
      url = "https://pypi.python.org/packages/source/x/xlwt/xlwt-0.7.5.tar.gz";
      md5 = "59cb5efd55319465dfcd25e6a485f03c";
    };
  };

### Test requirements

  
}
