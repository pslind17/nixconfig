{ self, config, lib, pkgs, ... }: {
  # Based on https://carjorvaz.com/posts/the-holy-grail-nextcloud-setup-made-easy-by-nixos/
  services = {
    nginx.virtualHosts = {
      "next" = {
        forceSSL = true;
      };
    };
    # 
    nextcloud = {
      enable = true;
      hostName = "next";
      # Need to manually increment with every major upgrade.
      package = pkgs.nextcloud32;
      # Let NixOS install and configure the database automatically.
      database.createLocally = true;
      # Let NixOS install and configure Redis caching automatically.
      configureRedis = true;
      # Increase the maximum file upload size.
      maxUploadSize = "16G";
      https = true;
      autoUpdateApps.enable = true;
      extraAppsEnable = true;
      settings = {
        overwriteProtocol = "https";
        default_phone_region = "US";
      };
      config = {
        dbtype = "pgsql";
        adminuser = "admin";
        adminpassFile = "/home/pslind/adminpass";
      };
      # Suggested by Nextcloud's health check.
      phpOptions."opcache.interned_strings_buffer" = "16";
    };
  };
}
