{ pkgs, config, ... }: {

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostName = "next.tail26b773.ts.net";

    database.createLocally = true;

    config = {
      dbtype = "pgsql";
      adminpassFile = "/home/pslind/admin-pass-file";

      # Good practice when behind HTTPS / reverse proxy
      overwriteprotocol = "https";
    };

    extraAppsEnable = true;

    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        news
        contacts
        calendar
        tasks
        notes

        # 🔥 AI Apps
        integration_openai
        assistant
        textprocessing
        files_texteditor
        smartpicker;
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
