{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;

    # GTX 1080 (Pascal) requires the legacy 580 branch
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };
}