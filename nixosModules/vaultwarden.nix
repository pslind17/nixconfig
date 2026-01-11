{ config, pkgs, ... }:

{
  services.vaultwarden = {
    enable = true;

    config = {
      # IMPORTANT: must be https
      DOMAIN = "https://vaultwarden.${config.networking.hostName}.ts.net";

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;

      WEBSOCKET_ENABLED = true;
      SIGNUPS_ALLOWED = false;
    };
  };

  # Vaultwarden does NOT need firewall access
  # because only Tailscale talks to it
}
