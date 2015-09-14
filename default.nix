with import <nixpkgs> {};
let 
  name = "odoo-tink"; 
  
in buildPythonPackage {
  name = "odoo-tink";
  buildInputs = [ pkgs.python pkgs.libxml2 pkgs.libxslt pkgs.openldap pkgs.cyrus_sasl pkgs.postgresql pkgs.libtiff pkgs.freetype pkgs.python27Packages.gevent];
  src = null;
  # gcc won't find sasl.h if it's not in the include part
  NIX_CFLAGS_COMPILE = "-I${pkgs.cyrus_sasl}/include/sasl -I${pkgs.libxml2}/include/libxml";
}
