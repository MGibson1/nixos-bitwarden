{
  pkgs,
  inputs,
  vars,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../nixos/modules/home-manager.nix

    ../users/admin.nix

    ../nixos/modules/locale.nix
    ../nixos/modules/nix.nix
    ../nixos/modules/security.nix
  ];

  # Yubikey
  services.pcscd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable sensors
  environment.systemPackages = [
    pkgs.lm_sensors
    # Agenix for secret management
    inputs.agenix.packages."${vars.system}".default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure keymap in X11
  services.xserver.xkb = vars.keyboard;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
