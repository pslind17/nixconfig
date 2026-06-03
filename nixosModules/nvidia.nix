{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = false; # GTX 1080 requires proprietary driver

    modesetting.enable = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}