{
  description = "nixos flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";

    # NUR (Nix User Repository)
    nur.url = "github:nix-community/nur";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NixOS profiles to optimize settings for different hardware.
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # flatpak
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable-v3";

    poetry2nix.url = "github:nix-community/poetry2nix";
  };

  outputs = {self, nixpkgs, nixpkgs-unstable, nur, home-manager, nixos-hardware, poetry2nix, catppuccin, ... }@inputs:
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
  let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = nixpkgs.packages.${system};
    overlay-unstable = final: prev: {
     unstable = import nixpkgs-unstable {
       inherit system;
       config.allowUnfree = true;
      };
    };
#    overlay-opensnitch-unstable = final: prev: {
#      opensnitch = nixpkgs-unstable.legacyPackages."x86_64-linux".opensnitch;
#    };
  in {
    nixosConfigurations = {
      francesco-nixos = nixpkgs.lib.nixosSystem {
        specialArgs =
        let
          user = "francesco";
          gitName = "Francesco070";
        in { inherit inputs gitName user; }; # Pass flake inputs to our config
        modules = [
         ({ config, pkgs, ... }: { nixpkgs.overlays = [
         overlay-unstable
         ]; })
         ./global/configuration.nix
         ./global/home/services/displaylink.nix
        ];
      };
    };
  };
}