{ config, pkgs, lib, ... }: {

security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = "${pkgs.sunshine}/bin/sunshine";
  };

hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

services.seatd.enable = true;
security.polkit.enable = true;

services.avahi.publish.enable = true;
services.avahi.publish.userServices = true;

networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 47984 47989 47990 48010 ];
  allowedUDPPortRanges = [
    { from = 47998; to = 48000; }
    #{ from = 8000; to = 8010; }
  ];
};

}