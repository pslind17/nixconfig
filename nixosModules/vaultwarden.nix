{ self, config, lib, pkgs, ... }:

{
    services.vaultwarden.enable = true;
    networking.firewall.allowedTCPPorts = [ 8000 443 ];
}