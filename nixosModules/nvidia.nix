{ config, pkgs, ... }:

{
  # 1. Allow unfree packages for proprietary Nvidia binaries
  nixpkgs.config.allowUnfree = true;

  # 2. CRITICAL FOR NIXOS 26.05: Disable the broken systemd stage 1 bootloader.
  # This reverts your boot process back to the working scripted setup.
  boot.initrd.systemd.enable = false;

  # 3. Force system to an stable long term support kernel (LTS)
  boot.kernelPackages = pkgs.linuxPackages_6_6;

  # 4. Block fallback modules from claiming the GTX 1080 
  boot.blacklistedKernelModules = [ "nouveau" "nvidiafb" ];

  # 5. Native scripted Stage-1 driver injection
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.kernelParams = [ 
    "nvidia-drm.modeset=1" 
    "nvidia_drm.modeset=1" 
    "nvidia_drm.fbdev=1" 
  ];

  # 6. Enable standard graphics architecture framework
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # 7. Nvidia Module Pins 
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false; # Required: Open modules are totally broken on Pascal architecture
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # 8. Modern Wayland Multi-Monitor Environment Mappings
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    CLUTTER_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
