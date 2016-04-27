nix-env -f release.nix -iA odoo-tink.python27

Filter src:
  src-filter = path: type:
    with pkgs.lib;
    !elem (basename path) [".git" "odoo.egg-info" "_bootstrap_env" "result" "__pycache__" ".eggs" ".po" ".jpg" ".png" ".csv" ".xml"] &&
    (last (splitString "." path) != "pyc");
  odoo-tink-src = builtins.filterSource src-filter ./.;

Check size

du -scl $(nix-store -qR ./result) | sort -n
du -scl $(nix-store -qR /nix/var/nix/profiles/system) | sort -n | tail -20 | head -19 | while read size path; do echo $size $path; nix-store -q --referrers $path | sed 's:/nix/store/: :'; done

