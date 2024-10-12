{ config, pkgs, inputs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader-Konfiguration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Hostname und Netzwerkeinstellungen
  networking.hostName = "nixos"; 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Netzwerkmanager aktivieren
  networking.networkmanager.enable = true;

  # Zeitzone und Locale
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "de_CH.UTF-8";

  # X11 und GNOME Desktop aktivieren
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Benutzerkonto definieren
  users.users.francesco = {
    isNormalUser = true;
    description = "Francesco Palazzo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ thunderbird ];
  };

  # Home Manager aktivieren
  home-manager.enable = true;  # Aktiviere Home Manager
  home-manager.users.francesco = import ./home.nix;  

  # Weitere Einstellungen für Programme
  programs.firefox.enable = true;

  # Bluetooth aktivieren
  hardware.bluetooth.enable = true;

  # Erlaube unfreie Pakete
  nixpkgs.config.allowUnfree = true;

  # Systempakete definieren
  environment.systemPackages = with pkgs; [
    vim
    wget
    vscode
    lf
    git
  ];

  # NixOS-Version festlegen
  system.stateVersion = "24.05"; 
}
