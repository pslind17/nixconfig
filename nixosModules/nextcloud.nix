{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;

    datadir = "/var/lib/nextcloud";
    hostName = "cloud.example.com";

    # Database
    database.createLocally = true;

    # Redis
    configureRedis = true;

    # HTTPS handled by nginx + acme, not by Nextcloud itself
    https = false;
  };

  services.nginx = {
    enable = true;
    virtualHosts."cloud.example.com" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://unix:/run/nextcloud-phpfpm/nextcloud.sock";
        extraConfig = ''
          client_max_body_size 512M;
          fastcgi_buffers 64 4K;
        '';
      };
    };
  };

  # PHP-FPM pool for Nextcloud
  services.phpfpm.pools.nextcloud = {
    user = "nextcloud";
    group = "nextcloud";
    phpPackage = pkgs.php83;
    settings = {
      "listen" = "/run/nextcloud-phpfpm/nextcloud.sock";
      "listen.owner" = "nginx";
      "listen.group" = "nginx";
      "pm" = "dynamic";
      "pm.max_children" = "32";
      "pm.start_servers" = "2";
      "pm.min_spare_servers" = "2";
      "pm.max_spare_servers" = "4";
    };
  };

  # Firewall
  networking.firewall.allowedTCPPorts = [ 80 443 ];


}


