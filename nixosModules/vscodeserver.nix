{ config, pkgs, ... }:

{
  services.openvscode-server.enable = true;
  services.openvscode-server.port = 3000;

  networking.firewall.allowedTCPPorts = [ 3000 ];
}
