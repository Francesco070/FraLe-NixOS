# FraLe-NixOS

## Contributors
Francesco070 &amp; XLordPlatypus

## Installation

Install NixOS with the Graphical ISO Image.

Reboot and then:

```shell

nix-env -iA nixos.git

git clone https://github.com/Francesco070/FraLe-NixOS.git

cp /etc/nixos/hardware-configuration.nix /home/<user>/FraLe-NixOS

sudo nixos-rebuild switch --flake .#<user>-nixos

```



