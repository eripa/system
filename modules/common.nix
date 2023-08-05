{
  self,
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./primaryUser.nix
    ./nixpkgs.nix
  ];

  nixpkgs.overlays = builtins.attrValues self.overlays;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  user = {
    description = "Eric Ripa";
    home = "${
      if pkgs.stdenvNoCC.isDarwin
      then "/Users"
      else "/home"
    }/${config.user.name}";
    shell = pkgs.zsh;
  };

  # bootstrap home manager using system config
  hm = {
    imports = [
      ./home-manager
    ];
  };

  # let nix manage home-manager profiles and use global nixpkgs
  home-manager = {
    extraSpecialArgs = {inherit self inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # environment setup
  environment = {
    systemPackages = with pkgs; [
      # editors
      neovim

      # standard toolset
      coreutils-full
      findutils
      diffutils
      gawk
      gnugrep
      gnupg
      gnused
      curl
      wget
      git
      jq
      yq-go
      dnsutils
      mtr
      btop
      p7zip
      xz
      zip
      mmv
      neofetch

      # helpful shell stuff
      bat
      fzf
      ripgrep

      # other
      age
      rclone
      rsync
      tree

      # homelab stuff
      q
      docker-client
      kubectl
      kubectx
      kubernetes-helm
      kustomize
      argocd
    ];
    etc = {
      home-manager.source = "${inputs.home-manager}";
      nixpkgs.source = "${inputs.nixpkgs}";
      stable.source = "${inputs.stable}";
    };
    # list of acceptable shells in /etc/shells
    shells = with pkgs; [bash zsh fish];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
        jetbrains-mono
        source-code-pro
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
      ];
  };
}
