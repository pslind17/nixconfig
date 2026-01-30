{ pkgs, lib, config, ... }: {

  services.xserver.enable = true;
  # You may need to comment out "services.displayManager.gdm.enable = true;"
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

}
