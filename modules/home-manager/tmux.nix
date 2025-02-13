{...}: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    historyLimit = 100000;
    mouse = false;
    terminal = "xterm-256color";
    clock24 = true;
    extraConfig = ''
      ## shared
      ${builtins.readFile ./tmux-shared.conf}

      # make it easy to send C-b
      bind-key b send-prefix

      # prefix again goes to last window
      bind-key C-b last-window

      # reload
      bind r source-file ~/.tmux.conf

      # keybindings to make resizing easier
      bind -r C-h resize-pane -L
      bind -r C-j resize-pane -D
      bind -r C-k resize-pane -U
      bind -r C-l resize-pane -R

      # make it so that I can hold down prefix key for these
      bind-key C-d detach
      bind-key C-n next-window
      bind-key C-p previous-window
    '';
  };
  home.file.".config/tmux/tmux-main.conf" = {
    enable = true;
    text = builtins.readFile ./tmux-main.conf;
  };
}
