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
      "bartender"
      "orbstack"
      "firefox-developer-edition"
      "alfred"
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
      "arq"
    ];
  };
}
