{ pkgs, ... }:
{
  services.nginx = {
  enable = true;

  virtualHosts."next" = {
    forceSSL = true;
    enableACME = false;

    sslCertificate = "/var/lib/nginx/next.crt";
    sslCertificateKey = "/var/lib/nginx/next.key";
  };
};

  services.nextcloud = {
    package = pkgs.nextcloud32;
    enable = true;
    https = true;
    hostName = "next.tail26b773.ts.net";
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = "/home/pslind/nixconfig/nixosModules/admin-pass-file";
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}


