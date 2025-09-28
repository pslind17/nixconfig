{ config, pkgs, ... }:

{
  # For setting the Nextcloud admin password file (if desired)
  environment.etc."nextcloud-admin-pass".text = "youradminpassword";

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;

    datadir = "/var/lib/nextcloud";
    hostName = "localhost";

    # Use SQLite for testing / minimal usage (not for production)
    config.dbtype = "sqlite";

    # Optionally, set the admin password via the file we made above
    config.adminpassFile = "/etc/nextcloud-admin-pass";
  };

  services.nginx = {
    enable = true;
    virtualHosts."localhost" = {
      # Listen on port 8080 (HTTP) by default
      listen = [ { addr = "0.0.0.0"; port = 8080; } ];

      root = "${config.services.nextcloud.package}/share/nextcloud";

      locations."/" = {
        proxyPass = "http://unix:/run/nextcloud-phpfpm/nextcloud.sock";
      };
    };
  };

  services.phpfpm.pools.nextcloud = {
    user = "nextcloud";
    group = "nextcloud";
    phpPackage = pkgs.php83;
    settings = {
      "listen" = "/run/nextcloud-phpfpm/nextcloud.sock";
      "listen.owner" = "nginx";
      "listen.group" = "nginx";
    };
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}
