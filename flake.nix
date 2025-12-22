{
  description = "NixOS desktop ocnfiguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
 king = nixpkgs.lib.nixosSystem {
   specialArgs = { inherit system; };

   modules = [
   ./hosts/king/configuration.nix
   ];
   };
  };
  
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
 iso = nixpkgs.lib.nixosSystem {
   specialArgs = { inherit system; };

   modules = [
   ./hosts/iso/configuration.nix
   ];
   };
  };

  };
}
