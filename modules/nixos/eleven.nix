{
  config,
  pkgs,
  ...
}: {
   services.udev.extraHwdb = ''
    evdev:input:b0003v05ACp0249e0111*
      KEYBOARD_KEY_70039=esc # CAPSLOCK
  '';


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "eleven";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Vancouver";

  programs.light.enable = true;

  services.hardware.pommed.enable = true;
  services.mbpfan.enable = true;
  services.acpid.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  programs.sway = {
    enable = true;
  };
}
