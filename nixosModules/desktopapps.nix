# desktopapps.nix

{ pkgs, lib, config, ... }: {

    environment.systemPackages = with pkgs; [
    gimp
    blender
    microsoft-edge
    vscode
    libreoffice
    rpi-imager
    kdePackages.partition-manager
    freecad
    vlc
    libsForQt5.kdeconnect-kde
    distrobox
    f3d
    arduino
    openrocket
    orca-slicer
    popsicle
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

  
  }
