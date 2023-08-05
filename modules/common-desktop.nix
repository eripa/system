{
  self,
  inputs,
  config,
  pkgs,
  ...
}: {
  hm = {
    imports = [
      ./home-manager
      ./home-manager/desktop.nix
    ];
  };
}
