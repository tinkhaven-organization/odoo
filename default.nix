{ pkgs ? (import <nixpkgs> {}), lib ? pkgs.lib, pythonPackages ? "python27Packages" }:
let
  inherit (lib) filterAttrs mapAttrs attrValues;
  basePythonPackages = with builtins; if isAttrs pythonPackages
    then pythonPackages
    else getAttr pythonPackages pkgs;

  elem = builtins.elem;
  basename = path: with pkgs.lib; last (splitString "/" path);

  src-filter = path: type:
    with pkgs.lib;
    !elem (basename path) [".git" "odoo.egg-info" "_bootstrap_env" "result" "__pycache__" ".eggs"] &&
    (last (splitString "." path) != "pyc") &&
    (last (splitString "." path) != "po") &&
    (last (splitString "." path) != "jpg") &&
    (last (splitString "." path) != "png")
    ;

  odoo-tink-src = builtins.filterSource src-filter ./.;

  localOverrides = pythonPackages: {
    # odoo-tink = pythonPackages.odoo-tink.override (odoo-tink: {
    #   src = odoo-tink-src;
    #   buildInputs = [] ++ odoo-tink.buildInputs;
    # });
  };

  pythonPackagesWithLocals = basePythonPackages.override (a: {
    self = pythonPackagesWithLocals;
  })
  // (scopedImport {
        self = pythonPackagesWithLocals;
        super = basePythonPackages;
        inherit pkgs;
        inherit (pkgs) fetchurl;
      } ./python-packages.nix)
  ;

  myPythonPackages = 
    (pythonPackagesWithLocals
    // (localOverrides pythonPackagesWithLocals));
  myAttrNames = builtins.attrNames myPythonPackages;
  myFilteredPkgs = builtins.filter (key: key != "avro3k") myAttrNames;
  #myFilteredPythonPkgs = filterAttrs (k: v: k != "avro3k") myPythonPackages;
  myFilteredPythonPkgs = attrValues (filterAttrs (k: v: k != "avro3k") myPythonPackages);

  odoo-tink = with pkgs.python27Packages; builtins.trace myFilteredPythonPkgs pkgs.buildPythonPackage {
    name = "odoo-tink-8.0.0";
    buildInputs = [
      setuptools
      mock
      pkgs.libxml2
      pkgs.libyaml
    ];
    # propagatedBuildInputs = myFilteredPkgs;
    # propagatedBuildInputs = myFilteredPythonPkgs;
    doCheck = false;
    src = odoo-tink-src;
    my-var = myFilteredPkgs;
  };

in odoo-tink
