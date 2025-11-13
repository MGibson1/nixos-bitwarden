{pkgs, ...}: {
  imports = [
    ../../nixos/audio.nix
  ];

  environment.systemPackages = [
    pkgs.easyeffects
  ];
}
