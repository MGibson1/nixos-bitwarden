{pkgs, ...}: {
  imports = [
    ../../nixos/modules/audio.nix
  ];

  environment.systemPackages = [
    pkgs.easyeffects
  ];
}
