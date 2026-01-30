{ pkgs, modulesPath, ... }: {

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../../nixosModules/basics.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

}