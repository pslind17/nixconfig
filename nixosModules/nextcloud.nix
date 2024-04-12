{ self, config, lib, pkgs, ... }:

{
  services = {
    nginx.virtualHosts = {
      "next" = {
      };
    };

    nextcloud = {
      enable = true;
      hostName = "next";

       # Need to manually increment with every major upgrade.
      package = pkgs.nextcloud27;

      # Let NixOS install and configure the database automatically.
      database.createLocally = true;

      # Let NixOS install and configure Redis caching automatically.
      configureRedis = true;

      # Increase the maximum file upload size to avoid problems uploading videos.
      maxUploadSize = "16G";
      https = true;

      #S

      config = {
        overwriteProtocol = "https";
        defaultPhoneRegion = "PT";
        dbtype = "pgsql";
        adminuser = "admin";
        adminpassFile = "/home/pslind/admin-pass";
      };
    };
  };
}
