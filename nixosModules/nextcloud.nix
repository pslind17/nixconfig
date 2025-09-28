{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;

    # Pick your desired version
    package = pkgs.nextcloud29;

    datadir = "/var/lib/nextcloud";
    hostName = "cloud.example.com";

    # Database
    database.createLocally = true;

    # Caching
    configureRedis = true;

    # This replaces the old configureNginx
    nginx.enable = true;

    # Optional: force HTTPS (works with ACME)
    https = true;
  };

  # Open firewall ports
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Enable nginx globally
  services.nginx.enable = true;

}

