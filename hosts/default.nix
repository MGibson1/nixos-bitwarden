{
  pkgs,
  inputs,
  vars,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../nixos/home-manager.nix

    ../users/admin.nix

    ../nixos/locale.nix
    ../nixos/nix.nix
    ../nixos/security.nix
  ];

  # Yubikey
  services.pcscd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable sensors
  environment.systemPackages = [
    pkgs.lm_sensors
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure keymap in X11
  services.xserver.xkb = vars.keyboard;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
