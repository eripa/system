{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bat.nix
    ./direnv.nix
    ./fzf.nix
    ./atuin.nix
    ./git.nix
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

    # define package definitions for current user environment
    packages = with pkgs; [
      cb
      comma
      findutils
      helm-docs
      nix
      nixfmt
      nixpkgs-fmt
      pre-commit
      # python with default packages
      (python3.withPackages
        (ps:
          with ps; [
            requests
          ]))
      shellcheck
      sysdo
      treefmt
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
