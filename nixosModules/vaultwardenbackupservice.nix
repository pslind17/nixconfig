{ pkgs, lib, config, ... }: {
    services.borgbackup.jobs.vaultwarden = {
  paths = [ "/var/lib/bitwarden_rs" ];
  repo = "borg@advisor:/srv/vaultwarden/borg";

  compression = "zstd";
  startAt = "daily"; # or hourly/weekly if you want

  encryption = {
    mode = "repokey-blake2";
    passCommand = "cat /run/secrets/borg-vaultwarden-pass";
  };

  prune.keep = {
    daily = 7;
    weekly = 4;
    monthly = 3;
  };
};
}