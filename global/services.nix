{ inputs, config, lib, pkgs, user, ... }: {
  imports = [
#    ./opensnitch.nix
  ];
  services = {
    displayManager = {
      defaultSession = "gnome";
    };
    xserver = {
      enable = true;
      # Enable the GNOME Desktop Environment.
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager.gnome.enable = true;
      # Configure keymap in X11
      xkb = {
        variant = "";
        layout = "ch";
      };
    };

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = [ pkgs.foomatic-db-ppds ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    flatpak = {
      enable = true;
    };

    # sudo freshclam after failed service
    clamav = {
      updater.enable = true;
      daemon = {
        enable = true;
        settings = {
          LogFile =  "/var/log/clamdscan.log";
          LogSyslog = true;
          ExcludePath = "^(/home/${user}/.local/share/containers|/home/${user}/.cache/JetBrains|/home/${user}/.cache/mozilla/firefox/)";
          MaxDirectoryRecursion = 100;
        };
      };
    };

    # nautilus quick preview
    gnome.sushi.enable = true;
  };
}