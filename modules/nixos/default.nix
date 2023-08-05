{
  config,
  pkgs,
  lib,
  ...
}: {
  # bundles essential nixos modules
  imports = [../common.nix];

  environment.systemPackages = with pkgs; [];

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users = {
      "${config.user.name}" = {
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
        hashedPassword = "$6$jRlsGwuBaNkeWKYi$VZcp1g9umUMqhAfwm9WTEYQaCN7cf0K4bwz4Eev5LTFFmzEJMSCOwkfHJvPl6E0kjV7CrPu23W0/JbDLRmWIc0";
      };
    };
  };

  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_US.UTF-8";
  services.localtimed.enable = true;
  services.openssh.enable = true;
  sound.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
