{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "localhost";
    https = false;

    config = {
      dbtype = "sqlite";   # simplest DB
      adminuser = "admin"; # required
      adminpassFile = "/var/lib/nextcloud/admin-pass"; # required
    };

    datadir = "/var/lib/nextcloud/data";
  };

  services.nginx = {
    enable = true;

    virtualHosts."localhost" = {
      forceSSL = false;
      listen = [{
        addr = "0.0.0.0";
        port = 8123;
        ssl = false;
      }];
    };
  };

  networking.firewall.allowedTCPPorts = [ 8123 ];
}
