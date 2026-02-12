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
    };
  };

    extraAppsFromGit = {
  assistant = {
    url = "https://github.com/nextcloud/assistant.git";
    rev = "v2.1.0";  # we will fix this in a moment
    sha256 = "";
  };

  textprocessing = {
    url = "https://github.com/nextcloud/textprocessing.git";
    rev = "v2.1.0";
    sha256 = "";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

}