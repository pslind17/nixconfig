{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;

    # Which version of Nextcloud you want (omit for latest available)
    package = pkgs.nextcloud31;

    hostName = "localhost";  # ignored if no SSL, but required
    https = false;           # disable SSL, plain HTTP only
    listenAddresses = [ "0.0.0.0:8123" ]; # serve on all IPs, port 8123

    database = {
      type = "postgresql";
      host = "localhost";
      user = "nextcloud";
      passwordFile = "/var/lib/nextcloud/db-pass"; # create manually with `chmod 600`
      name = "nextcloud";
    };

    # Auto create admin user on first start (set password in a file)
    adminpassFile = "/var/lib/nextcloud/admin-pass";
    adminuser = "admin";
  };

  # Enable PostgreSQL
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

  networking.firewall.allowedTCPPorts = [ 8123 ];
}
