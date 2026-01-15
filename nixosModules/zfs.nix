{ pkgs, lib, config, ... }: {
  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.autoScrub.enable = true;

  networking.hostId = "54a31bce"; # 8 hex chars

  services.zfs.autoSnapshot = {
  enable = true;
  frequent = 4;
  hourly = 24;
  daily = 7;
  weekly = 4;
  monthly = 3;
};

}
