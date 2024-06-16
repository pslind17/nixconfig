{ pkgs, lib, config, ... }: {

    environment.systemPackages = with pkgs; [
    seafile-server
  ];
}