{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    stream-pi-server
  ];

  networking.firewall.allowedTCPPorts = [
    9000
  ];

}
