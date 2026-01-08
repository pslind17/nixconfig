{ pkgs, ... }:

{
  ############################
  # Nextcloud (no webserver)
  ############################
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;

    hostName = "next";
    https = true;

    webserver = "none";   # 🔴 IMPORTANT: prevents duplicate nginx config

    database.createLocally = true;

    config = {
      dbtype = "pgsql";
      adminpassFile = "/home/pslind/nixconfig/nixosModules/admin-pass-file";
    };
  };

  ############################
  # Nginx (manual, single vhost)
  ############################
  services.nginx = {
    enable = true;

    virtualHosts."next" = {
      forceSSL = true;
      enableACME = false;

      sslCertificate = "/var/lib/nginx/next.crt";
      sslCertificateKey = "/var/lib/nginx/next.key";

      root = "/var/lib/nextcloud";

      locations."/" = {
        tryFiles = "$uri $uri/ /index.php$request_uri";
      };

      locations."~ \\.php$" = {
        extraConfig = ''
          fastcgi_split_path_info ^(.+\.php)(/.+)$;
          fastcgi_pass unix:/run/phpfpm/nextcloud.sock;
          fastcgi_index index.php;
          include ${pkgs.nginx}/conf/fastcgi.conf;
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        '';
      };
    };
  };

  ############################
  # Firewall
  ############################
  networking.firewall.allowedTCPPorts = [ 443 ];
}
