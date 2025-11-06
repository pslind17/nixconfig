{ self, config, lib, pkgs, ... }:

{
    services.vaultwarden.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 443 ];
}