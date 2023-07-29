{...}: {
   # define package definitions for only nixos
    packages = with pkgs; [
        docker
    ];
}
