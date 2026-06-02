{ config, pkgs, ... }:

{
  # 1. License agreements (Required for Nvidia binaries)
  nixpkgs.config.allowUnfree = true;

  # 2. Hard-lock system to an older, highly reliable LTS kernel
  # This fixes updates that aggressively drop older Pascal architectures
  boot.kernelPackages = pkgs.linuxPackages_6_6;

  # 3. Prevent fallback driver modules from hijacking the GPU
  boot.blacklistedKernelModules = [ "nouveau" "nvidiafb" ];

  # 4. Force stage-1 initialization parameters
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  
  boot.kernelParams = [ 
    "nvidia-drm.modeset=1" 
    "nvidia_drm.modeset=1" 
    "nvidia_drm.fbdev=1" 
  ];

  # 5. Core graphics framework backend hooks
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # 6. Specific Driver Branch Locking
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false; # Required: True open-source modules crash on GTX 1080s
    nvidiaSettings = true;
    
    # We choose the production branch instead of the shifting "stable" tag
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # 7. Wayland environment desktop variable handshakes
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    CLUTTER_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
