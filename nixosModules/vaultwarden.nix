{ config, pkgs, lib, ... }:

{
  # ...existing imports/config...

  services.vaultwarden.enable = true;
  networking.firewall.allowedTCPPorts = [ 8000 443 ];


}