{ pkgs ? (import <nixpkgs> {}) }:
with pkgs.lib; rec {
  make-odoo-tink = {pythonVersion}: {
    name = "python${pythonVersion}";
    value = import ./default.nix {
      inherit pkgs;
      pythonPackages = "python${pythonVersion}Packages";
    };
  };

  odoo-tink = pkgs.recurseIntoAttrs (
    builtins.listToAttrs (map make-odoo-tink ([
      {pythonVersion = "27";}
      {pythonVersion = "33";}
      {pythonVersion = "34";}
    ] ++ optional (hasAttr "python35Packages" pkgs) {pythonVersion = "35";}))
  );

  # docs = pkgs.stdenv.mkDerivation {
  #   name = "odoo-tink-docs";
  #   src = ./docs;
  #   outputs = [ "html" ];  # TODO: PDF would be even nicer on CI
  #   buildInputs = [ pip2nix.python34 ] ++ (with  pkgs.python34Packages; [
  #     sphinx
  #   ]);
  #   buildPhase = ''make html'';
  #   installPhase = "cp -r _build/html $html";
  # };
}
