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

    ../nixos/modules/fonts.nix
    ../nixos/modules/locale.nix
    ../nixos/modules/nix.nix
    ../nixos/modules/security.nix
    ../nixos/modules/system-vars.nix
  ];

  # Yubikey
  services.pcscd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  environment.systemPackages = [
    # Enable sensors
    pkgs.lm_sensors
    # Agenix for secret management
    inputs.agenix.packages."${vars.system}".default
  ];

  age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"]; # isn't set automatically for some reason

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure keymap in X11
  services.xserver.xkb = vars.keyboard;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
