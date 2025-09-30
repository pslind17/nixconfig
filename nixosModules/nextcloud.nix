{ self, config, lib, pkgs, ... }:

{
  services = {


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

      config = {
        overwriteProtocol = "https";
        defaultPhoneRegion = "PT";
        dbtype = "pgsql";
        adminuser = "admin";
        adminpassFile = "/path/to/nextcloud-admin-pass";
      };
    };
  };
}

