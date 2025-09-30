{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29; # or omit
    hostName = "localhost";
    https = false;

    config.dbtype = "sqlite"; # simplest (no PostgreSQL service needed)
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
