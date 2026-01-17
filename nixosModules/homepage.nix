{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts."_" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 8067;
        }
      ];

      root = "/home/pslind/homepage";
      index = "index.html";

      locations."/" = {
        tryFiles = "$uri $uri/ =404";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8067 ];
}
