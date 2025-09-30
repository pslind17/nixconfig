{ config, pkgs, ... }:

{
  services.openvscode-server.enable = true;
  services.openvscode-server.host = "0.0.0.0";
  services.openvscode-server.port = 3000;

  services.openvscode-server.connectionToken = lib.mkForce "";

  networking.firewall.allowedTCPPorts = [ 3000 ];
}
