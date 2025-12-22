# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

let
  nextcloudVersion = pkgs.nextcloud32; # change if you want another supported version
in
{
  imports = [];

  # Nextcloud admin password stored in a file
  environment.etc."nextcloud-admin-pass".text = "MyAdminPassword123!";

  services.nextcloud = {
    enable = true;

    # Use the chosen Nextcloud version package
    package = nextcloud32;

    # Basic hostname: use a placeholder or your Tailscale Magic DNS name
    hostName = "nextcloud.local";

    # Point at file with admin password
    config.adminpassFile = "/etc/nextcloud-admin-pass";

    # SQLite for minimal setup
    config.dbtype = "sqlite";

    # Since we’re behind Tailscale (TLS via Tailscale Serve), do NOT enable the module’s HTTPS
    https = false;

    # If clients access via HTTPS via a proxy (Tailscale Serve),
    # ensure correct protocol used in links if needed
    settings = {
      overwriteprotocol = "https";
    };
  };

  # Nginx is auto-configured by the Nextcloud module unless overridden.
  # Adjust ports if Tailscale Serve expects a specific port.

  # Optional: allow HTTP only access internally (if using Tailscale Serve HTTP)
  networking.firewall.allowedTCPPorts = [ 80 ];

  # You might prefer to bind Nginx to localhost only, since Tailscale Serve
  # forwards traffic over localhost:
  networking.interfaces.lo.extraConfig = ''
    # no extra settings; placeholder if customizing later
  '';
}




