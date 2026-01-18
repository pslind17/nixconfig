{ config, pkgs, ... }: {
       services.guacamole-server = {
       enable = true;
       host = "0.0.0.0";
       port = 4822;
       userMappingXml = ./user-mapping.xml;
   };
}