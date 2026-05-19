{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # 1. Base Graphics & Wayland support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Force your Display Manager (like GDM or SDDM) to use Wayland
  services.xserver.displayManager.gdm.wayland = true; 

  services.xserver.videoDrivers = [ "nvidia" ];

  # 2. Nvidia Driver Configuration for Pascal + Wayland
  hardware.nvidia = {
    # Modesetting is STRICTLY required for Wayland
    modesetting.enable = true;

    # Fixes graphical corruption/flicker after suspend
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # MUST be false for GTX 1080 (open-source modules break Pascal Wayland)
    open = false; 

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # 3. Environment variables for Wayland + Nvidia
  environment.sessionVariables = {
    # Hint Electron apps (Discord, VS Code) to use Wayland natively
    NIXOS_OZONE_WL = "1";
    
    # Force hardware acceleration in Clutter-based applications
    CLUTTER_BACKEND = "wayland";
    
    # Directs Qt applications to utilize Wayland
    QT_QPA_PLATFORM = "wayland";
    
    # Required if using a wlroots compositor (like Hyprland or Sway)
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
