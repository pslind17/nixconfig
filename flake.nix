{
  description = "NixOS desktop configuration";

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

      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
          ./hosts/desktop/configuration.nix
        ];
      };

      lightlaptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
          ./hosts/lightlaptop/configuration.nix
        ];
      };

      next = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
          ./hosts/next/configuration.nix
        ];
      };

      squire = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
          ./hosts/squire/configuration.nix
        ];
      };

      advisor = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
          ./hosts/advisor/configuration.nix
        ];
      };

      iso = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
          ./hosts/iso/configuration.nix
        ];
      };
    };
  };
}
