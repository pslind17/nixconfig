{ self, config, lib, pkgs, ... }: {
  environment.etc."nextcloud-admin-pass".text = "FRERGge452greha!$";
services.nextcloud = {
  enable = true;
  package = pkgs.nextcloud31;
  hostName = "localhost";
  config.adminpassFile = "/etc/nextcloud-admin-pass";
  config.dbtype = "sqlite";
};
}
