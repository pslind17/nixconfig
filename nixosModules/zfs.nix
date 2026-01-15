{ pkgs, lib, config, ... }: {
  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.autoScrub.enable = true;

  networking.hostId = "deadbeef"; # 8 hex chars
}
