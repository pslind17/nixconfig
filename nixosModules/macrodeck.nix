{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    macrodeck
  ];

  networking.firewall.allowedTCPPorts = [
    8190  # device connection
    8191  # web client
  ];
}
