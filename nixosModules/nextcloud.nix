{{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;

    datadir = "/var/lib/nextcloud";
    hostName = "cloud.example.com";

    # Database (must be explicit)
    database = {
      createLocally = true;
      type = "sqlite";  # alternatives: "mysql" or "sqlite"
    };

    # Redis cache
    configureRedis = true;

    # HTTPS handled by nginx
    https = false;
  };

  services.nginx = {
    enable = true;
  };

  services.phpfpm.pools.nextcloud = {
    user = "nextcloud";
    group = "nextcloud";
    phpPackage = pkgs.php83;
    settings = {
      "listen" = "/run/nextcloud-phpfpm/nextcloud.sock";
      "listen.owner" = "nginx";
      "listen.group" = "nginx";
      "pm" = "dynamic";
      "pm.max_children" = "32";
      "pm.start_servers" = "2";
      "pm.min_spare_servers" = "2";
      "pm.max_spare_servers" = "4";
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

}
