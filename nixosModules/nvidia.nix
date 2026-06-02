{ config, pkgs, ... }:

{
  # 1. Allow Proprietary Drivers
  nixpkgs.config.allowUnfree = true;

  # 2. Force Early Initramfs Kernel Loading (Crucial Step)
  # This forces NixOS to load the hardware drivers immediately during stage 1 boot
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  
  # Kernel boot arguments to override display falls
  boot.kernelParams = [ 
    "nvidia-drm.modeset=1" 
    "nvidia_drm.modeset=1" 
    "nvidia_drm.fbdev=1" 
  ];

  # 3. Base Graphics Stack Configuration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Direct the X11 server and Wayland layers to bind the hardware driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # 4. Driver Module Specifications
  hardware.nvidia = {
    modesetting.enable = true;
    
    # Required to prevent frame drops on suspend
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # MUST be false for GTX 1080 Pascal hardware
    open = false; 

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # 5. Native Wayland Environment Handshakes
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    CLUTTER_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
