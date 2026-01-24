{ config, pkgs, lib, ... }:

{
  #### Sunshine ####
  environment.systemPackages = [
    pkgs.sunshine
  ];

  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    source = "${pkgs.sunshine}/bin/sunshine";
    capabilities = [
      "cap_setpcap+ep"
      "cap_sys_nice+ep"
    ];
  };

  #### Graphics (Intel iGPU / VAAPI) ####
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  #### Input emulation (THIS FIXES PERMISSION DENIED) ####
  boot.kernelModules = [
    "uinput"
    "uhid"
  ];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input"
    KERNEL=="uhid", MODE="0660", GROUP="input"
  '';

  #### Seat / Polkit (required for Wayland input) ####
  services.seatd.enable = true;
  security.polkit.enable = true;

  #### Avahi discovery (Moonlight auto-discovery) ####
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  #### Firewall (Sunshine defaults) ####
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 47984 47989 47990 48010 ];
    allowedUDPPortRanges = [
      { from = 47998; to = 48000; }
    ];
  };

  #### User permissions ####
  users.users.pslind.extraGroups = [
    "input"
    "video"
    "seat"
  ];
}
