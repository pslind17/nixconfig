{ config, pkgs, ... }:

{
  # 1. Allow unfree packages (Mandatory for proprietary Nvidia drivers)
  nixpkgs.config.allowUnfree = true;

  # 2. Hard-inject Kernel Boot Arguments to force DRM mode setting
  boot.kernelParams = [ 
    "nvidia-drm.modeset=1" 
    "nvidia_drm.modeset=1" 
    "nvidia_drm.fbdev=1" 
  ];

  # 3. Graphics Framework Config
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load the explicit driver kernel module via XServer framework
  services.xserver.videoDrivers = [ "nvidia" ];

  # 4. Strict Nvidia Configuration targeted for GTX 1080 (Pascal Architecture)
  hardware.nvidia = {
    modesetting.enable = true;
    
    # Prevents graphical artifacting on suspend/resume steps
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # MUST stay false. Open-source modules completely break GTX 10-series cards
    open = false; 

    nvidiaSettings = true;

    # Explicit fallback pinning bypasses broken "stable" aliases from the update
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # 5. Environment Variables for System-Wide Wayland & Hardware Acceleration
  environment.sessionVariables = {
    # Directs Electron applications (Discord, VS Code) to run via native Wayland
    NIXOS_OZONE_WL = "1";
    
    # Hardware acceleration UI frameworks
    CLUTTER_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";

    # Maps out direct rendering pathways
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
