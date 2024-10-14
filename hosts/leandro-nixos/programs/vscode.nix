{ inputs, lib, config, pkgs, user, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
    bbenoist.nix
    ];
  };
}