# module1.nix

{ pkgs, lib, config, ... }: {

  options = {
    basics.enable = 
      lib.mkEnableOption "enables basics";
  };

  config = lib.mkIf config.basics.enable {

    # Enable services needed for all machines
    services.tailscale.enable = true;

    # Packages needed on all machines
    environment.systemPackages = with pkgs; [
  	neofetch
    git
    ];
    

    networking.networkmanager.enable = true;
    time.timeZone = "America/Vancouver";
    i18n.defaultLocale = "en_CA.UTF-8";

    services.openssh = {
        enable = true;
        passwordAuthentication = true;
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];


  };
