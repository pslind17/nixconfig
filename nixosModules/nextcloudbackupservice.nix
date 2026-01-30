{ config, pkgs, ... }: {

  services.borgbackup.jobs.nextcloud = {
    paths = [ "/var/lib/nextcloud" ];

    repo = "borg@advisor:/srv/nextcloud/borg";

    compression = "zstd";

    startAt = "daily";

    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /run/secrets/borg-nextcloud-pass";
    };

    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };

    # 🔴 THIS is what you are missing
    doInit = false;
  };

}