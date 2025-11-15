{
  vars,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./audio.nix
    ./fprint.nix
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
  vars.gdm.background = ../../home-manager/backgrounds/innovation.png;

  home-manager = {
    users.${vars.user}.imports = [
      ../../home-manager/mgibson
    ];
  };

  networking.hostName = "steeltoes";

  # setup luks fido2 unlocking
  boot.initrd.luks.fido2Support = true;
  boot.initrd.luks.devices."luks-871d65f5-4657-4c8c-8977-9a12c8a75aac" = {
    # Annoyingly luks swap devices aren't part of the hardware configuration script
    device = "/dev/disk/by-uuid/871d65f5-4657-4c8c-8977-9a12c8a75aac";
    fido2.credentials = [
      "a6e7b5fc9f401118b3502cb3908183c4e1fd642d459eb6a44c35b7bcd987dc85040b94fcb79f7d17f0249c7be2cdff05"
    ];
  };
  # Also add fido2 credential to root luks device
  boot.initrd.luks.devices."luks-ce068190-213e-4378-acbe-02eac377c476" = {
    fido2.credentials = [
      "a6e7b5fc9f401118b3502cb3908183c4e1fd642d459eb6a44c35b7bcd987dc85040b94fcb79f7d17f0249c7be2cdff05"
    ];
  };

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
