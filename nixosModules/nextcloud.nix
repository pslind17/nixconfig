{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;

    datadir = "/var/lib/nextcloud";
    hostName = "localhost";

    # Explicit DB type required since 25.05
    config.dbtype = "sqlite";
  };

  # Open firewall for HTTP (Nextcloud will configure nginx itself)
  networking.firewall.allowedTCPPorts = [ 80 ];
}
