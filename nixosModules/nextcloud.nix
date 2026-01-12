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
    inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    notes = pkgs.fetchNextcloudApp {
        sha256 = "sha256-Xr1SRSmXo2r8yOGuoMyoXhD0oPVm/0/ISHlmNZpJYsg=";
        url = "https://github.com/nextcloud-releases/notes/releases/download/v4.12.4/notes-v4.12.4.tar.gz";
        license = "agpl3";
    };
    extraAppsEnable = true;

  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
};
}