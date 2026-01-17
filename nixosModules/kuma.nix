{ pkgs, config, ... }:

{
  services.uptime-kuma = {
    enable = true;
    settings = {
      HOST = "squire";
      PORT = "3001";
    };
  };

  networking.firewall.allowedTCPPorts = [ 3001 ];
}
