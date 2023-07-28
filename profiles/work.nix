{pkgs, ...}: {
  user.name = "eripa";
  hm = {imports = [./home-manager/work.nix];};

  security.pki.certificateFiles = ["${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"];
}
