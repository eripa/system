{...}: {
  programs.powerline-go = {
    enable = true;
    modules = [
      "host"
      "nix-shell"
      "venv"
      "vgo"
      "kube"
      "terraform-workspace"
      "ssh"
      "cwd"
      "perms"
      "git"
      "jobs"
      "exit"
      "duration"
    ];
    modulesRight = [
      "time"
    ];
    newline = true;
    settings = {
      shell = "zsh";
      static-prompt-indicator = true;
      numeric-exit-codes = true;
      hostname-only-if-ssh = false;
      cwd-max-depth = 0;
      max-width = 0;
      eval = true;
      theme = "default";
      time = "15:04:05";
      cwd-mode = "plain";
    };
  };
}
