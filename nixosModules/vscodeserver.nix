{ config, pkgs, ... }:

{
  services.openvscode-server.enable = true;
  services.openvscode-server.port = 80;

  networking.firewall.allowedTCPPorts = [ 80 ];
}
