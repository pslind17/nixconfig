{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;

    datadir = "/var/lib/nextcloud";
    hostName = "localhost";

    # Explicit DB type required in >=25.05
    config.dbtype = "sqlite";

    # Disable auto-setup so no adminpassFile is required
    autoSetup = false;
  };

  # Nextcloud module will handle nginx + php-fpm for us
  networking.firewall.allowedTCPPorts = [ 80 ];
}
