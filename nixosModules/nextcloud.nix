{ pkgs, ... }:

{
  ############################
  # Nextcloud
  ############################
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;

    hostName = "next";
    https = true;

    database.createLocally = true;

    config = {
      dbtype = "pgsql";
      adminpassFile = "/home/pslind/nixconfig/nixosModules/admin-pass-file";
    };

    # Tell Nextcloud/nginx where the self-signed cert is
    nginx = {
      sslCertificate = "/var/lib/nginx/next.crt";
      sslCertificateKey = "/var/lib/nginx/next.key";
    };
  };

  ############################
  # Nginx (required by Nextcloud)
  ############################
  services.nginx.enable = true;

  ############################
  # Firewall
  ############################
  networking.firewall.allowedTCPPorts = [
    443
  ];
}

