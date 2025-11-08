{ self, config, lib, pkgs, ... }: {
  services = {
    nginx = {
      enable = true;            # ensure nginx is enabled
    };

    nextcloud = {
      enable = true;
      hostName = "next";
      package = pkgs.nextcloud31;
      database.createLocally = true;
      configureRedis = true;
      maxUploadSize = "16G";
      https = false;            # set false for testing, enable when certs are configured
      settings = {
        overwriteProtocol = "http";
        default_phone_region = "US";
      };
      config = {
        dbtype = "pgsql";
        adminuser = "admin";
        adminpassFile = "/home/pslind/adminpass";
      };
      phpOptions."opcache.interned_strings_buffer" = "16";
    };
  };
}

