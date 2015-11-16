with import <nixpkgs> {};
let 
  name = "odoo-tink"; 
  preConfigure = "set -x";
  unpackPhase = ''
    echo "Unpack Phase"
  '';

in buildPythonPackage {
  name = "odoo-tink";
  buildInputs = [ 
    pkgs.python27Packages.pillow 
    pkgs.python27Packages.mock 
    pkgs.python27Packages.setuptools 
    pkgs.python 
    pkgs.libxml2 
    pkgs.libyaml 
    pkgs.libjpeg_original 
    pkgs.libxslt 
    pkgs.openldap 
    pkgs.cyrus_sasl 
    pkgs.postgresql 
    pkgs.libtiff 
    pkgs.freetype 
    pkgs.python27Packages.gevent
    pkgs.python27Packages.distutils_extra
  ];
  src = null;
  # gcc won't find sasl.h if it's not in the include part
  NIX_CFLAGS_COMPILE = "-I${pkgs.cyrus_sasl}/include/sasl -I${pkgs.libxml2}/include/libxml -I${pkgs.libyaml} -I${pkgs.libjpeg_original}";

  doCheck = false;
  # When used as `nix-shell --pure`
  #shellHook = ''
  #  touch /tmp/buildPython
  #'';
  # used when building environments
  #extraCmds = ''
  #   touch /tmp/buildPython
  #'';
}
