# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs, lib, config, pkgs, user, gitName, flatpaks, ... }: {
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    inputs.home-manager.nixosModules.home-manager
    ../hosts/${user}-nixos/hardware-configuration.nix
    ./pkgs.nix
    ./virtualisation.nix
    ./services.nix
  ];

  nixpkgs = {
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
#       })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "Tue, 08:15";
      options = "--delete-older-than 7d";
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_CH.UTF-8";

  # Configure console keymap
  console.keyMap = "sg";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;


  #sound = {
  #  enable = true;
  #  pipewire.enable = true;
  #  pipewire.wireplumber.enable = true;
  #  hardware.pulseaudio.enable = false;
  #  security.rtkit.enable = true;
  #};

  programs.zsh.enable = true;
  programs.gnome-terminal.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.variables = { EDITOR = "vim"; };
  environment.pathsToLink = [ "/share/zsh" ];

  users.users = {
    ${user} = {
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      initialPassword = "12345";
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.zsh;
    };
  };

#  gtk.iconCache.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs pkgs user gitName; };
    users = {
      # Import your home-manager configuration
      ${user}.imports = [
        inputs.flatpaks.homeManagerModules.default
        inputs.catppuccin.homeManagerModules.catppuccin
        ../hosts/${user}-nixos/home.nix
      ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
