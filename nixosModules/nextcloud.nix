{ pkgs, ... }:

{
  ############################
  # Nextcloud (manages nginx)
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
  };

  ############################
  # Nginx (MERGE SSL ONLY)
  ############################
  services.nginx = {
    enable = true;

    virtualHosts."next" = {
      forceSSL = true;
      enableACME = false;

      sslCertificate = "/var/lib/nginx/next.crt";
      sslCertificateKey = "/var/lib/nginx/next.key";
    };
  };

  ############################
  # Firewall
  ############################
  networking.firewall.allowedTCPPorts = [ 443 ];
}
