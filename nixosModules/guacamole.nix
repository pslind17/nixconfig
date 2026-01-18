{ config, pkgs, ... }:

{
  services.guacamole-server.enable = true;

  services.guacamole-client = {
    enable = true;
    userMappingXml = pkgs.writeText "user-mapping.xml" ''
    <user-mapping>
      <authorize username="admin" password="password">
        <connection name="Local SSH">
          <protocol>ssh</protocol>
          <param name="hostname">127.0.0.1</param>
          <param name="port">22</param>
        </connection>
      </authorize>
    </user-mapping>
  '';
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
