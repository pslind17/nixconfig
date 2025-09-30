{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29; # or omit for default
    hostName = "localhost";
    https = false;

    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbpass = "super-strong-db-password"; # must be plain string
      dbname = "nextcloud";
    };

    nginx.listen = [
      { addr = "0.0.0.0"; port = 8123; ssl = false; }
    ];
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      {
        name = "nextcloud";
        ensureDBOwnership = true;
        # This sets the same password as above
        password = "super-strong-db-password";
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 8123 ];
}
