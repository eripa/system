{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bat.nix
    ./direnv.nix
    ./alacritty.nix
    ./fzf.nix
    ./git.nix
    ./kitty.nix
    ./nvim
    ./shell.nix
    ./ssh.nix
    ./tldr.nix
    ./tmux.nix
    ./powerline-go.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  home = let
  in {
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.05";
    sessionVariables = {
      GPG_TTY = "/dev/ttys000";
      EDITOR = "nvim";
      VISUAL = "nvim";
      CLICOLOR = 1;
      LSCOLORS = "ExFxBxDxCxegedabagacad";
      # KAGGLE_CONFIG_DIR = "${config.xdg.configHome}/kaggle";
    };
    sessionPath = [
      "${config.home.homeDirectory}/.rd/bin"
      "${config.home.homeDirectory}/.local/bin"
    ];

    # define package definitions for current user environment
    packages = with pkgs; [
      age
      cb
      comma
      coreutils-full
      curl
      diffutils
      fd
      ffmpeg
      findutils
      gawk
      gnugrep
      gnupg
      gnused
      google-cloud-sdk
      helm-docs
      httpie
      q
      dnsutils
      mtr
      btop
      p7zip
      xz
      zip
      kubectl
      kubectx
      kubernetes-helm
      kustomize
      mmv
      neofetch
      nix
      nixfmt
      nixpkgs-fmt
      parallel
      pre-commit
      # python with default packages
      (python3.withPackages
        (ps:
          with ps; [
            requests
          ]))
      rclone
      rsync
      shellcheck
      sysdo
      tree
      treefmt
      trivy
      yq-go
      jq
      yt-dlp
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
    dircolors.enable = true;
    go.enable = true;
    gpg.enable = true;
    htop.enable = true;
    jq.enable = true;
    k9s.enable = true;
    lazygit.enable = true;
    less.enable = true;
    man.enable = true;
    nix-index.enable = true;
    ripgrep.enable = true;
    yt-dlp.enable = true;
    zoxide.enable = true;
  };
}
