{settings, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;

      font.normal.family = "Source Code Pro";
      font.size = 12;
      font.style = "Regular";

      window = {
        decorations = "full";
        dynamic_padding = true;
        dimensions = {
          lines = 3;
          columns = 200;
        };
      };

      scroling.history = 0; # use tmux instead
      selection.save_to_clipboard = true;

      hints.enabled = [
        {
          regex = "(ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\\u0000-\\u001F\\u007F-\\u009F<>\"\\\\s{-}\\\\^⟨⟩`]+";
          command = "open";
          post_processing = true;
          mouse = {
            enabled = true;
            mods = "Super";
          };
        }
      ];

      colors = {
        primary.background = "#2b303b";
        primary.foreground = "#d8dee9";
        primary.dim_foreground = "#a5abb6";
        cursor.text = "#2e3440";
        cursor.cursor = "#d8dee9";
        vi_mode_cursor.text = "#2e3440";
        vi_mode_cursor.cursor = "#d8dee9";
        selection.text = "CellForeground";
        selection.background = "#4c566a";
        search.matches.foreground = "CellBackground";
        search.matches.background = "#88c0d0";
        search.footer_bar.background = "#434c5e";
        search.footer_bar.foreground = "#d8dee9";
        normal.black = "#3b4252";
        normal.red = "#bf616a";
        normal.green = "#7ece7e";
        normal.yellow = "#ebcb8b";
        normal.blue = "#81a1c1";
        normal.magenta = "#b48ead";
        normal.cyan = "#88c0d0";
        normal.white = "#e5e9f0";
        bright.black = "#4c566a";
        bright.red = "#bf616a";
        bright.green = "#7ece7e";
        bright.yellow = "#ebcb8b";
        bright.blue = "#81a1c1";
        bright.magenta = "#b48ead";
        bright.cyan = "#8fbcbb";
        bright.white = "#eceff4";
        dim.black = "#373e4d";
        dim.red = "#94545d";
        dim.green = "#809575";
        dim.yellow = "#b29e75";
        dim.blue = "#68809a";
        dim.magenta = "#8c738c";
        dim.cyan = "#6d96a5";
        dim.white = "#aeb3bb";
      };
    };
  };
}
