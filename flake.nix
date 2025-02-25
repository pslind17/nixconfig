{
  description = "NixOS desktop ocnfiguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
       };
     };

in
{

nixosConfigurations = {
 nixos = nixpkgs.lib.nixosSystem {
   specialArgs = { inherit system; };

   modules = [
   ./hosts/desktop/configuration.nix
   ];
   };
  };

nixosConfigurations = {
 lightlaptop = nixpkgs.lib.nixosSystem {
   specialArgs = { inherit system; };

   modules = [
   ./hosts/lightlaptop/configuration.nix
   ];
   };
  };

nixosConfigurations = {
 next = nixpkgs.lib.nixosSystem {
   specialArgs = { inherit system; };

   modules = [
   ./hosts/next/configuration.nix
   ];
   };
  };

nixosConfigurations = {
 rpi = nixpkgs.lib.nixosSystem {
   specialArgs = { system = "aarch64-linux"; };

   modules = [
   ./hosts/rpi/configuration.nix
   ];
   };
  };

  };
}
