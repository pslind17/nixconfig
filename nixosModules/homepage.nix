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

      root = "/pslind/home/homepage";

      locations."/" = {
        index = "index.html";
        tryFiles = "$uri $uri/ =404";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8067 ];
}
