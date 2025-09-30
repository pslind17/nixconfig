{ config, pkgs, ... }:

{
  services.openvscode-server.enable = true;
  services.openvscode-server.host = "0.0.0.0";
  services.openvscode-server.port = 3000;

  networking.firewall.allowedTCPPorts = [ 3000 ];
}
