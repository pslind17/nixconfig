{ config, pkgs, ... }:

{
  services.openvscode-server.enable = true;
  services.openvscode-server.port = 8;

  networking.firewall.allowedTCPPorts = [ 80 ];
}
