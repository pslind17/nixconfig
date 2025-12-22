{ pkgs, config, ... }: {

environment.etc."nextcloud-admin-pass".text = "HFIURHgroijgiro^&^grhiugp";
services.nextcloud = {
  enable = true;
  package = pkgs.nextcloud31;
  hostName = "next";
  config.adminpassFile = "/etc/nextcloud-admin-pass";
  config.dbtype = "sqlite";
};

}


