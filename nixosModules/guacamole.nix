{ config, pkgs, ... }:

{
  services.guacamole-server.enable = true;

  services.guacamole-client = {
    enable = true;
    userMappingXml = ./user-mapping.xml;
  };

  services.nginx = {
    enable = true;

    virtualHosts."guacamole" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 8085;
        }
      ];

      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
        proxyWebsockets = true;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8085 ];
}
