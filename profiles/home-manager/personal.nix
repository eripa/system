{...}: {
  programs.git = {
    userEmail = "eric@ripa.io";
    userName = "Eric Ripa";
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHy9/GrJa2WpdTMWgtg/9qZe0TftCL14Wovzg8uhfge";
      signByDefault = true;
    };
  };
}
