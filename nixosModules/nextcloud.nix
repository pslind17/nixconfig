{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;

    datadir = "/var/lib/nextcloud";
    hostName = "localhost";

    config = {
      dbtype = "sqlite";
      adminuser = "admin";
      adminpassFile = "/var/nextcloud-admin-pass"; # must exist
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}
