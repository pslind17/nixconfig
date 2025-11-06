{ config, pkgs, lib, ... }:

{
  # ...existing imports/config...

  services.vaultwarden.enable = true;

  systemd.services.vaultwarden.serviceConfig = {
    Environment = ''
      ROCKET_ADDRESS=0.0.0.0
      ROCKET_PORT=8000
    '';
  };

  networking.firewall.allowedTCPPorts = lib.mkForce (config.networking.firewall.allowedTCPPorts or []) ++ [ 8000 ];
}