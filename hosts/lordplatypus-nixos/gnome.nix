{ pkgs, ... }: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        favorite-apps = [
          "org.gnome.Console.desktop"
          "org.gnome.Nautilus.desktop"
          "brave.desktop"
          "zed-editor.desktop"
        ];

        disable-user-extensions = false;
        # `gnome-extensions list` for a list
        enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "clipboard-indicator@tudmotu.com"
          "trayIconsReloaded@selfmade.pl"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "noannoyance-fork@vrba.dev"
        ];
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };


      "org/gnome/shell/extensions/dash-to-dock" = {
        dock-position = "MIDDLE";
        extend-height = true;
        dock-fixed = true;
        dash-max-icon-size = 32;
        isolate-workspaces = true;
        custom-theme-shrink = true;
        disable-overview-on-startup = true;
        show-trash = false;
      };
    };
  };

}