{ pkgs, ... }:
{
  services = {
    nginx.virtualHosts = {
      "next" = {
        forceSSL = true;
        enableACME = true;
      };
    };
  };
  services.nextcloud = {
    package = pkgs.nextcloud32;
    enable = true;
    https = true;
    hostName = "next";
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


