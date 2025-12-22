{ pkgs, ... }:
{
  services.nextcloud = {
    package = pkgs.nextcloud31;
    enable = true;
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


