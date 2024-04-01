# desktopapps.nix

{ pkgs, lib, config, ... }: {

  options = {
    desktopapps.enable = 
      lib.mkEnableOption "enables desktopapps";
  };

  config = lib.mkIf config.desktopapps.enable {

    environment.systemPackages = with pkgs; [
    gimp
    blender
    microsoft-edge
    vscode
    libreoffice
    etcher
    rpi-imager
    partition-manager
    cura
    freecad
    vlc
    libsForQt5.kdeconnect-kde
    distrobox
    f3d
    arduino
  ];

    nixpkgs.config.permittedInsecurePackages = [
    "electron-19.1.9"
  ];
  
  services.printing.enable = true;
  
  };
