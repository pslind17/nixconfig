{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29; # optional
    hostName = "localhost";
    https = false;

    config.dbtype = "sqlite";

    nginx.listen = [
      { addr = "0.0.0.0"; port = 8123; ssl = false; }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 8123 ];
}
