{ inputs, lib, config, pkgs, ... }: {
  services.pipewire = {
    enable = true;
    wireplumber.enable = true; 
  };
}
