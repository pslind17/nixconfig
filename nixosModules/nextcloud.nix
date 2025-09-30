{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30; # ✅ upgrade here
    hostName = "localhost";
    https = false;

    config.dbtype = "sqlite"; # simplest option
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
