{ config, pkgs, lib, ... }:

{
  ############################
  ## Kernel + input support ##
  ############################

  boot.kernelModules = [ "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input"
    KERNEL=="event*", SUBSYSTEM=="input", MODE="0660", GROUP="input"
  '';

  users.groups.input = {};

  users.users.yourUsername = {
    isNormalUser = true;
    extraGroups = [
      "input"
      "video"
      "audio"
      "seat"
    ];
  };

  ################################
  ## Sunshine permissions setup ##
  ################################

  # Give Sunshine the capability it needs for uinput
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine";
  };

  services.sunshine = {
    enable = true;
    openFirewall = false; # we define ports manually
    capSysAdmin = true;
  };

  ############################
  ## Graphics / VAAPI stack ##
  ############################

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  #####################
  ## Seat / Wayland  ##
  #####################

  services.seatd.enable = true;
  security.polkit.enable = true;

  ###################
  ## Networking   ##
  ###################

  services.avahi = {
    enable = true;
    publish.enable = true;
    publish.userServices = true;
  };

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      47984
      47989
      47990
      48010
    ];

    allowedUDPPortRanges = [
      { from = 47998; to = 48000; }
    ];
  };
}
