{pkgs, ...}: {
  home.packages = with pkgs; [
    github-cli
    diff-so-fancy
  ];
  programs.git = {
    userName = "Eric Ripa";
    enable = true;
    extraConfig = {
      credential.helper =
        if pkgs.stdenvNoCC.isDarwin
        then "osxkeychain"
        else "cache --timeout=1000000000";
      commit.verbose = true;
      fetch.prune = true;
      http.sslVerify = true;
      init.defaultBranch = "main";
      pull.rebase = true;
      push.followTags = true;
      push.autoSetupRemote = true;
    };
    aliases = {
      br = "branch -a";
      s = "status -s -u";
      st = "status";
      cl = "log --stat -C -2";
      c = "commit";
      co = "checkout";
      ph = "push";
      pl = "pull";
      sm = "submodule";
      cam = "commit -a -m";
      scrub = "!git reset --hard && git clean -fd";
      pub = "!git push --set-upstream origin \"$(git rev-parse --abbrev-ref HEAD)\"";
      cs = "status";
      rv = "remote -v";
      pur = "pull --rebase";
      whatis = "show -s --pretty='tformat:%h (%s, %ad)' --date=short";
      orphank = "!gitk --all `git reflog | cut -c1-7`&";
      orphanl = "!git log --pretty=oneline --abbrev-commit --graph --decorate `git reflog | cut -c1-7`";
      k = "!exec gitk --all&";
      ri = "rebase --interactive --autosquash";
      pushnotes = "!sh -c 'git push $1 refs/notes/*' -";
      fetchnotes = "!sh -c 'git fetch $1 refs/notes/*:refs/notes/*' -";
      aliases = "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'";
      whitespaceviolations = "!git diff --check $(git empty-tree-sha1)";
      patchforthis = "!git diff -p $(git empty-tree-sha1)";
      d = "diff --color-words";
      dh = "diff HEAD";
      dc = "diff --staged";
      dw = "diff --word-diff";
      dcw = "diff --color-words";
      dm = "!git diff | mate";
      dv = "!git diff | vim";
      diffall = "diff HEAD";
      lsignored = "clean -ndX";
      lsignored2 = "ls-files --others --ignored --exclude-standard";
      lsuntracked = "ls-files --others --exclude-standard";
      lsunstaged = "diff --name-status";
      lsstaged = "diff --name-status --staged";
      lshistory = "log --name-status";
      who = "shortlog -s --";
      lp = "log -p";
      lod = "log --oneline --decorate";
      lpo = "log --pretty=oneline --abbrev-commit --graph --decorate --all";
      lg = "log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an %C(auto)%G?>%Creset' --abbrev-commit --date=relative";
      lgg = "log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an %C(auto)%G?>%Creset' --abbrev-commit --date=iso8601";
      l1 = "log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
      lf = "log --pretty=fuller";
      lsm = "log -M --stat";
      hse = "log --stat -5";
      logr = "log -M";
      logr2 = "log --stat -M -2";
      logit = "log --stat -M";
      lwr = "log --stat -C";
      l = "log --stat -C";
      ll = "log --stat -C -3";
      logm = "log --stat -M";
      logcpy = "log --stat -1 -C -C";
      lol2 = "log --pretty=oneline --graph --abbrev-commit --all";
      lol = "log --oneline --graph --decorate";
      blg = "log --graph --decorate --all --abbrev-commit --pretty=oneline";
      slog = "log --graph --simplify-by-decoration --all --abbrev-commit --pretty=oneline";
      lgso = "log --graph --date=short --pretty=format:'%C(yellow)%h%Creset %cn%x09%cd %s%C(green bold)%d'";
      busypeople = "shortlog -6";
      busythisweek = "shortlog --since=one.week.ago";
      logme = "log --author=Eric --stat -C";
      configpushtracking = "config push.default tracking";
      configpushnothing = "config push.default nothing";
      configpushcurrent = "config push.default current";
      configpushsimple = "config push.default simple";
      cc-cache = "config --global credential.helper 'cache --timeout=300'";
      cc-off = "config --unset --global credential.helper";
      cc-helperosx = "config --global credential.helper 'osxkeychain'";
      cc-helperwin = "config --global credential.helper 'wincred'";
      cc-helperlin = "config --global credential.helper '/pathto/git-credential-gnome-key'";
      servehere = "daemon --verbose --informative-errors --reuseaddr --export-all --base-path=. --enable=receive-pack";
      dsf = ''!f() { [ -z "$GIT_PREFIX" ] || cd "$GIT_PREFIX" && git diff --color "$@" | diff-so-fancy  | less --tabs=4 -RFX; }; f'';
    };
    delta = {
      enable = false;
      options = {
        side-by-side = true;
        line-numbers = true;
      };
    };
    difftastic.enable = true;
    lfs.enable = true;
  };
}
