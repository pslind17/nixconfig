{ config, pkgs, lib, ... }:

{
  services.vaultwarden = {
  enable = true;
  dbBackend = "postgresql";
  # Store your variables like admin password here
  environmentFile = "/home/pslind/vaultwarden/.env";
  config = {
    SIGNUPS_ALLOWED = false;
    DOMAIN = "http://next";
  };
};
  networking.firewall.allowedTCPPorts = [ 8000 ];

}