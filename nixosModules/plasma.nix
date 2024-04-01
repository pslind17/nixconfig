# plasma.nix

{ pkgs, lib, config, ... }: {

  options = {
    plasma.enable = 
      lib.mkEnableOption "enables plasma";
  };

  config = lib.mkIf config.plasma.enable {
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
    services.xserver.displayManager.defaultSession = "plasmawayland";

    services.xserver.enable = true;

    services.xserver = {
    layout = "us";
    xkbVariant = "";
    };
  };
