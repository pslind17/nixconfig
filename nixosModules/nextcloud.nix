{ self, config, lib, pkgs, ... }:

{
  security.acme.acceptTerms = true;

  services = {
    nginx.virtualHosts = {
      "next" = {
        forceSSL = true;
        enableACME = true;
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
