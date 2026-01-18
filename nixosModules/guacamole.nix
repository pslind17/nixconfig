{ config, pkgs, ... }: {
       services.guacamole-server = {
       enable = true;
       host = "127.0.0.1";
       port = 4822;
       userMappingXml = ./user-mapping.xml;
   };
   networking.firewall.allowedTCPPorts = [ 4822 ];
}