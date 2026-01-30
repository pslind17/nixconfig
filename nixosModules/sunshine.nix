{ config, pkgs, lib, ... }: {

  #### Sunshine ####
  services.sunshine = {
    enable = true;
    openFirewall = false;
    capSysAdmin = true;
  };

  #### Graphics (Intel VAAPI) ####
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  #### Input emulation ####
  boot.kernelModules = [ "uinput" "uhid" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input"
    KERNEL=="uhid", MODE="0660", GROUP="input"
    KERNEL=="event*", SUBSYSTEM=="input", MODE="0660", GROUP="input"
  '';

  #### Seat / Wayland ####
  services.seatd.enable = true;
  security.polkit.enable = true;

  #### Avahi ####
  services.avahi = {
    enable = true;
    publish.enable = true;
    publish.userServices = true;
  };

  #### Firewall ####
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
