{
  description = "Bitwarden development flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    systems = ["x86_64-linux"];

    mkNixOsConfig = {
      path,
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules =
          [
            path
            # modules in all systems
            ./nixos/modules/system-vars.nix
            inputs.agenix.nixosModules.default
          ]
          ++ extraModules;
      };
  in {
    formatter = nixpkgs.lib.genAttrs systems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      # mgibson
      steeltoes = mkNixOsConfig {
        path = ./hosts/steeltoes;
      };
    };

    # Exposed so `nix build .#<name>` can iterate on a package without a full
    # nixos-rebuild. allowUnfree mirrors hosts/common.nix, which the vendor
    # binary packages under ./packages need in order to evaluate at all.
    packages = nixpkgs.lib.genAttrs systems (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      helix-assist = pkgs.callPackage ./packages/helix-assist.nix {};
    });
  };
}
