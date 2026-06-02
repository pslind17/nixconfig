{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # 1. Kernel and Boot parameters (Crucial for GTX 1080 / Wayland initialization)
  boot.kernelParams = [ "nvidia_drm.modeset=1" "nvidia_drm.fbdev=1" ];

  # 2. Base Graphics & Wayland support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # 3. Nvidia Driver Configuration for Pascal + Wayland
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

  # 4. Environment variables for Wayland + Nvidia + KDE Plasma
  environment.sessionVariables = {
    # Hint Electron apps (Discord, VS Code) to use Wayland natively
    NIXOS_OZONE_WL = "1";
    
    # Force hardware acceleration in Clutter-based applications
    CLUTTER_BACKEND = "wayland";
    
    # Directs Qt applications to utilize Wayland
    QT_QPA_PLATFORM = "wayland;xcb";

    # Hardware acceleration backing for Firefox/Chromium
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
