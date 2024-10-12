{ config, pkgs, ... }:

{
  # Benutzerinformationen für Home-Manager
  home.username = "francesco";
  home.homeDirectory = "/home/francesco";

  # Programme und Einstellungen
  programs.zsh.enable = true;

  home.packages = with pkgs; [
    neovim
    htop
    git
    firefox
  ];

  # ZSH mit Oh-My-Zsh
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.theme = "agnoster";
  programs.zsh.plugins = [ "git" "z" "sudo" ];

  # Vim Konfiguration
  programs.vim = {
    enable = true;
    extraConfig = ''
      set number
      syntax on
    '';
  };

  # GNOME als Window Manager
  xsession.enable = true;
  xsession.windowManager.gnome.enable = true;
}