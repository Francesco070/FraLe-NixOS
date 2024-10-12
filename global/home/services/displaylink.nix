{ inputs, lib, config, pkgs, ... }: {
  services.pipewire.wireplumber.enable = true;
}