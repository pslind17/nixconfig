{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;

    # Choose your desired Nextcloud release (e.g., 29, 28, etc.)
    package = pkgs.nextcloud31;

    # Data directory
    datadir = "/var/lib/nextcloud";

    # Configure the host/domain name
    hostName = "cloud.example.com";

    # Enable automatic database (uses PostgreSQL by default)
    database.createLocally = true;

    # Enable built-in redis cache for better performance
    configureRedis = true;

    # Automatically configure nginx + php-fpm
    configureNginx = true;

    # Optional: force HTTPS (make sure you configure certs below)
    https = true;
  };

  # Open firewall for HTTP/HTTPS
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Enable nginx (Nextcloud will add its own vhost config)
  services.nginx.enable = true;

  };

