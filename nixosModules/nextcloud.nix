{ pkgs, ... }:
{
  services.nextcloud = {
    package = pkgs.nextcloud31;
    enable = true;
    hostName = "next";
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = "/home/pslind/nixconfig/nixosModules/admin-pass-file";
    };
  };

  systemd.services.my-custom-service = {
    script = ''
      nextcloud-occ …
    '';
    serviceConfig = {
      inherit (config.systemd.services.nextcloud-cron.serviceConfig)
        User
        LoadCredential
        KillMode
        ;
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}


