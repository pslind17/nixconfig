{ config, pkgs, ... }:

{
  # Enable Nextcloud
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29; # optional: choose specific version
    hostName = "localhost";     # required even if https = false
    https = false;

    # Nextcloud database config
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbpasswordFile = "/var/lib/nextcloud/db-pass";
      dbname = "nextcloud";
    };

    # Force it to listen on port 8123, plain HTTP
    nginx.listen = [
      { addr = "0.0.0.0"; port = 8123; ssl = false; }
    ];
  };

  # Enable PostgreSQL and set up a DB + user for Nextcloud
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensureDBOwnership = true;
      }
    ];
  };

  # Open firewall port
  networking.firewall.allowedTCPPorts = [ 8123 ];
}
