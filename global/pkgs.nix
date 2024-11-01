{ config, pkgs, ... }:
#let
#  displaylink = pkgs.fetchurl {
#    url = "https://www.synaptics.com/sites/default/files/exe_files/2024-05/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.0-EXE.zip";
#    sha256 = "sha256-/HqlGvq+ahnuBCO3ScldJCZp8AX02HM8K4IfMzmducc=";
#  };
#in
{
  environment.gnome.excludePackages = with pkgs.gnome; [
    cheese
    simple-scan
    yelp
    geary
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-weather
    gnome-software
    gnome-tweaks
  ];

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    bind
    whois
    traceroute
    wget
    tree
    curl
    git
    bat
    htop
    gnumake
    firefox
    nodejs_20
    nodePackages.pnpm
    libreoffice
    podman-compose
    discord
    flatpak
    jetbrains-toolbox
  ];
}

