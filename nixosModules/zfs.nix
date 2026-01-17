{ pkgs, lib, config, ... }: {

networking.hostId = "05eb0a5b";
boot.supportedFilesystems = [ "zfs" ];

services.zfs = {
  autoScrub.enable = true;
};

services.zfs.autoSnapshot = {
  enable = true;
  frequent = 4;
  hourly = 24;
  daily = 7;
  weekly = 4;
  monthly = 3;
};

}