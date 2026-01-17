{ pkgs, lib, config, ... }: {

networking.hostId = "05eb0a5b";
boot.supportedFilesystems = [ "zfs" ];

services.zfs = {
  autoScrub.enable = true;
};
}