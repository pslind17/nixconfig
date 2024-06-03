# module1.nix

{ pkgs, lib, config, ... }: {

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

    services.openssh.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    users.users.pslind = {
    isNormalUser = true;
    description = "Peyton Slind";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
     # enableSSHSupport = true;
  # };
  services.avahi = {
  enable = true;
  nssmdns4 = true;
  openFirewall = true;
  };

  }
