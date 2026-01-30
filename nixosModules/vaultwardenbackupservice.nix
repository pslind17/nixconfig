{ pkgs, lib, config, ... }: {

  services.borgbackup.jobs.vaultwarden = {
    paths = [ "/var/lib/bitwarden_rs" ];
    repo = "borg@advisor:/srv/vaultwarden/borg";

    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /run/secrets/borg-vaultwarden-pass";
    };

    compression = "zstd";
    startAt = "daily";

    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };

    extraArgs = [ "--rsh=ssh -i /var/lib/borg/id_ed25519 -o IdentitiesOnly=yes" ];
  };

}
