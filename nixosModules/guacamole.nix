{ config, pkgs, ... }: {
       services.guacamole-server = {
       enable = true;
       host = "squire";
       port = 4822;
       userMappingXml = ./user-mapping.xml;
   };
}