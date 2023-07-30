{config, ...}: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
        auto_sync = true;
        db_path = "~/.atuin-history.db";
        key_path = "~/.atuin-key";
        session_path = "~/.atuin-session";
        sync_frequency = "1m";
        sync_address = "https://atuin.ripa.io";
        search_mode = "fuzzy";
        style = "compact";
        update_check = false;
    };
  };
}
