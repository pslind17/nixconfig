{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    datadir = "/var/lib/nextcloud";
    hostName = "localhost";
    config.dbtype = "sqlite";
    autoSetup = false;
  };

  # Nextcloud module will handle nginx + php-fpm for us
  networking.firewall.allowedTCPPorts = [ 80 ];
}
