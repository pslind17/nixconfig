{ pkgs, lib, ... }: {
    imports = [
        ./basics.nix
        ./desktopapps.nix
        ./plasma.nix
    ];
}