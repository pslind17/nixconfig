# desktopapps.nix

{ pkgs, lib, config, ... }: {

    environment.systemPackages = with pkgs; [
    gimp
    blender
    microsoft-edge
    vscode
    libreoffice
    rpi-imager
    freecad
    vlc
    distrobox
    f3d
    arduino
    openrocket
    orca-slicer
    popsicle
    python3
    kicad
    thunderbird
    sunshine
    openshot-qt
    shotcut
    kdePackages.kdenlive
  ];

    nixpkgs.config.permittedInsecurePackages = [
    "electron-19.1.9"
  ];
  
  services.printing.enable = true;
  services.flatpak.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

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
