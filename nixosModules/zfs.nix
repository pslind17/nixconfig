{ pkgs, lib, config, ... }: {
boot.supportedFilesystems = [ "zfs" ];

services.zfs = {
  autoScrub.enable = true;
};
}