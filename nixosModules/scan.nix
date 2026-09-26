{ config, pkgs, ... }: {
  # Enable SANE support for scanners
  hardware.sane.enable = true;

  # Optional: Add common airscan support for network/eSCL devices
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

  # Add your user to the scanner group (and lp if it also functions as a printer)
  users.users.YOURUSERNAME.extraGroups = [ "scanner" "lp" ];
}
