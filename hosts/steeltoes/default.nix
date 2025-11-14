{
  vars,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./audio.nix
    ../../nixos/modules/printing.nix

    ../../nixos/roles/desktop
    ../../nixos/roles/desktop/gnome.nix
    ../../nixos/roles/development

    ./hardware-configuration.nix

    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p16s-amd-gen4
    ../default.nix
  ];

  vars.user = "mgibson";
  vars.default-shell = pkgs.zsh;
  programs.zsh.enable = true;

  home-manager = {
    users.${vars.user}.imports = [
      ../../home-manager/mgibson
    ];
  };

  networking.hostName = "steeltoes";

  # Annoyingly luks swap devices aren't part of the hardware configuration script
  boot.initrd.luks.devices."luks-871d65f5-4657-4c8c-8977-9a12c8a75aac".device = "/dev/disk/by-uuid/871d65f5-4657-4c8c-8977-9a12c8a75aac";

  # Enable fprint
  services.fprintd.enable = true;

  environment.sessionVariables = {
    EDITOR = "micro";
  };

  # Enable tpm
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true; # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
  security.tpm2.tctiEnvironment.enable = true; # TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables
  users.users.${vars.user}.extraGroups = ["tss"]; # tss group has access to TPM devices

  system.stateVersion = "25.05";
}
