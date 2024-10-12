{
  description = "NixOS Configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # oder eine andere passende Version
    home-manager.url = "github:nix-community/home-manager"; # Stelle sicher, dass die URL korrekt ist
    # Weitere Abhängigkeiten...
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.default
        ];
      };
    };
}
