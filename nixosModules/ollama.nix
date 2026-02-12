{ config, pkgs, ... }: {
    services.ollama = {
  enable = true;
    host = "0.0.0.0";
  port = 11434;
};

environment.systemPackages = with pkgs; [
  ollama
];

networking.firewall.allowedTCPPorts = [
    11434
  ];
}