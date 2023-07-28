{pkgs, ...}: {
  home.packages = with pkgs; [
    cacert
    kubectl
    kubernetes-helm
    kustomize
    vault-bin
  ];
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "eripa@demonware.net";
    userName = "Eric Ripa";
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHy9/GrJa2WpdTMWgtg/9qZe0TftCL14Wovzg8uhfge";
      signByDefault = true;
    };
  };
}
