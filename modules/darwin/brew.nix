{...}: {
  homebrew = {
    enable = true;
    global = {
      brewfile = true;
    };
    brews = [
    ];

    taps = [
      "1password/tap"
      "homebrew/bundle"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/services"
    ];
    casks = [
      "1password"
      "1password-cli"
      # "alt-tab"
      "bartender"
      "docker"
      "firefox-developer-edition"
      "fork"
      "google-chrome"
      "iina"
      "obsidian"
      "stats"
      "utm"
      "visual-studio-code"
      "discord"
      "signal"
      "slack"
      "alacritty"
    ];
  };
}
