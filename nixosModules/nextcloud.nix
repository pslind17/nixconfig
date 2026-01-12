{ pkgs, ... }:
{
  services.nextcloud = {
    package = pkgs.nextcloud32;
    enable = true;
    hostName = "next.tail26b773.ts.net";
    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = "/home/pslind/nixconfig/nixosModules/admin-pass-file";
    };

  extraApps = {
    inherit (config.services.nextcloud.package.packages.apps) calendar tasks notes;
  extraAppsEnable = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
};