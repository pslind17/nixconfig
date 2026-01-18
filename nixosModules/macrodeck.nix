{ config, pkgs, ... }:

{
environment.systemPackages = with pkgs; [
  opendeck
];


  networking.firewall.allowedTCPPorts = [
    9000
  ];
}
