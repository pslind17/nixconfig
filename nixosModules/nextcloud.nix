{ config, pkgs, ... }:

{
  users.users.pslind.createHome = true;
  users.users.pslind.homeMode = "750";

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nextcloud = {
    enable = true;
    hostName = "next";
    package = pkgs.nextcloud31;
    database.createLocally = true;
    configureRedis = true;
    maxUploadSize = "16G";
    https = true;

    settings = {
      overwriteProtocol = "http";
      defaultPhoneRegion = "PT";
    };

    config = {
      dbtype = "pgsql";
      adminuser = "pslind";
      adminpassFile = "/var/lib/nextcloud/adminpass.txt";   };
  };
}
