{ pkgs, config, ... }: {
    services.uptime-kuma.enable = true;
    networking.firewall.allowedTCPPorts = [
    3001
  ];
}