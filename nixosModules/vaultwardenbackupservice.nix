{ pkgs, lib, config, ... }: {
  services.borgbackup.jobs.vaultwarden = {
    paths = [ "/var/lib/bitwarden_rs" ];
    repo = "borg@advisor:/srv/vaultwarden/borg";

    compression = "zstd";
    startAt = "daily";

    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /run/secrets/borg-vaultwarden-pass";
    };

    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };

    # 👇 ADD THIS
    environment = {
      BORG_RSH = "ssh -i /home/pslind/.ssh/borg_vaultwarden -o IdentitiesOnly=yes";
    };
  };
}
