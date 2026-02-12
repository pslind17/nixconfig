{ config, pkgs, ... }: {
    services.ollama = {
  enable = true;
};

environment.systemPackages = with pkgs; [
  ollama
];

networking.firewall.allowedTCPPorts = [
    11434
  ];
}