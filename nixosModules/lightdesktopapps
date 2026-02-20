{ pkgs, config, lib, ... }: {
    environment.systemPackages = with pkgs; [
    microsoft-edge
    vscode
    libreoffice
    rpi-imager
    vlc
    f3d
    arduino
    orca-slicer
    popsicle
    python3
    inkscape
    nextcloud-client
    bitwarden-desktop
    bitwarden-cli
  ];

    nixpkgs.config.permittedInsecurePackages = [
    "electron-19.1.9"
  ];

    services.printing.enable = true;


    hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };


}