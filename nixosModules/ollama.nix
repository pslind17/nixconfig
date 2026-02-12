{ config, pkgs, ... }: {
    services.ollama = {
  enable = true;
    host = "0.0.0.0";
  port = 11434;
};

environment.systemPackages = with pkgs; [
  ollama
];

  services.open-webui = {
    enable = true;
    port = 8080; # Default port
    host = "0.0.0.0";
    
    # Optional: Set environment variables for better privacy/config
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      # If using a remote Ollama instance, uncomment and set:
      # OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
    };
  };

networking.firewall.allowedTCPPorts = [
    11434
    8080
  ];
}