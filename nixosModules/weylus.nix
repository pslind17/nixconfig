{ pkgs, ... }:

{
  programs.weylus = {
    enable = true;
    # Automatically opens TCP 1701 and 9001 in the firewall
    openFirewall = true; 
    # Add your user to the weylus group for stylus/multi-touch support
    users = [ "pslind" ]; 
  };
}
