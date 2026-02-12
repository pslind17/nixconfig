{ pkgs, config, ... }: {

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostName = "next.tail26b773.ts.net";

    database.createLocally = true;

    config = {
      dbtype = "pgsql";
      adminpassFile = "/home/pslind/admin-pass-file";
    };

    extraAppsEnable = true;

    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        news contacts calendar tasks notes integration_openai;

        assistant = pkgs.fetchNextcloudApp rec {
  name = "assistant";
  url = "https://github.com/nextcloud-releases/assistant/releases/download/v3.1.0/assistant-v3.1.0.tar.gz";
  sha256 = "sha256-ANs6OygrtlZAQZ9TWTimu3Bo8RCeYf5BkcW7YZWsMEY=";
  license = "agpl3Plus";
};

    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

}