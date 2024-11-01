# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, user, ... }: {
  imports = [
    ./gnome.nix
    ./programs/git.nix
    ./programs/vscode.nix
    ../../global/home/programs/bash.nix
  ];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  home.packages = [
    pkgs.chromium
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.clipboard-indicator
    pkgs.gnomeExtensions.tray-icons-reloaded
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.user-themes
    pkgs.unstable.gnomeExtensions.noannoyance-fork
    pkgs.fira-code
    pkgs.unstable.jetbrains.phpstorm
    (pkgs.php82.buildEnv {
      extensions = ({ enabled, all }: enabled ++ (with all; [
        xdebug
      ]));
      extraConfig = ''
        memory_limit = 2G
        xdebug.mode=coverage
      '';
    })
    pkgs.unstable.symfony-cli
    pkgs.php82Packages.composer
  ];

  programs = {
    home-manager.enable = true;
  };

  catppuccin = {
      enable = true;
      accent = "blue";
      flavor = "frappe";
      pointerCursor = {
        enable = false;
        accent = "blue";
        flavor = "frappe";
      };
    };

    gtk = {
      enable = true;
      catppuccin = {
        enable = true;
        tweaks = [ "rimless" ];
        size = "compact";
        icon = {
          enable = true;
          accent = "blue";
          flavor = "frappe";
        };
        gnomeShellTheme = true;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}