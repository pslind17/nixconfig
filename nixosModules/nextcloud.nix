{ self, config, lib, pkgs, ... }:

{
  users.users.pslind.createHome = true;
  users.users.pslind.homeMode = "750";
  networking.firewall.allowedTCPPorts = [ 8000 80 443 ];

  services = {
    nginx.virtualHosts = {
      "next" = {
      };
    };

    nextcloud = {
      enable = true;
      hostName = "next";

       # Need to manually increment with every major upgrade.
      package = pkgs.nextcloud31;

      # Let NixOS install and configure the database automatically.
      database.createLocally = true;

      # Let NixOS install and configure Redis caching automatically.
      configureRedis = true;

      # Increase the maximum file upload size to avoid problems uploading videos.
      maxUploadSize = "16G";
      https = true;

      settings = {
        overwriteProtocol = "http";
        defaultPhoneRegion = "PT";
      };

      config = {
        dbtype = "pgsql";
        adminuser = "pslind";
        adminpassFile = "/var/lib/nextcloud/nextcloud.pass";
      };
    };
  };
}


