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

  networking.networkmanager.enable = true;

  environment.systemPackages = [
    pkgs.lm_sensors
    # Agenix for secret management
    inputs.agenix.packages."${vars.system}".default
  ];

  age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"]; # isn't set automatically for some reason

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.xkb = vars.keyboard;

  nixpkgs.config.allowUnfree = true;
}
