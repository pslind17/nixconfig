{ config, pkgs, ... }:
{
  services.openvscode-server = {
    enable = true;
    host = "0.0.0.0";
    port = 3000;
    connectionToken = "vscode"; # must not be empty
  };

  networking.firewall.allowedTCPPorts = [ 3000 ];
}
