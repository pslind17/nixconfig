{ config, pkgs, ... }:

{
  # 1. Mandatory licensing for proprietary modules
  nixpkgs.config.allowUnfree = true;

  # 2. Hard-blacklist open source Nouveau driver module configurations
  boot.blacklistedKernelModules = [ "nouveau" "nvidiafb" ];

  # 3. Inject Early Initramfs Kernel Loading
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  
  boot.kernelParams = [ 
    "nvidia-drm.modeset=1" 
    "nvidia_drm.modeset=1" 
    "nvidia_drm.fbdev=1" 
  ];

  # 4. Core Display Architecture Setup
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false; # Required: Open modules completely break Pascal hardware
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # 5. Environment Rules for Core Desktop Spanning
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    CLUTTER_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
