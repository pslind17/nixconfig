{ pkgs, lib, config, ... }: {
  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.autoScrub.enable = true;

  networking.hostId = "54a31bce"; # 8 hex chars
}
