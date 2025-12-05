{
  vars,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./audio.nix
    ./fix-sleep.nix
    # ./fprint.nix
    ../../nixos/modules/printing.nix

    ../../nixos/roles/desktop
    ../../nixos/roles/desktop/gnome.nix
    ../../nixos/roles/development
    ../../nixos/roles/development/windows.nix

    ./hardware-configuration.nix

    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p16s-amd-gen4
    ../default.nix
  ];

  vars.user = "mgibson";
  vars.gdm.background = ../../home-manager/backgrounds/innovation.png;
  vars.default-shell = pkgs.nushell;

  home-manager = {
    users.${vars.user}.imports = [
      ../../home-manager/mgibson
    ];
  };

  networking.hostName = "steeltoes";

  # Swapfile configuration
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 96 * 1024; # 96 GiB in MiB
    }
  ];

  # setup luks fido2 unlocking
  boot.initrd.luks.fido2Support = true;

  # Also add fido2 credential to root luks device
  boot.initrd.luks.devices."luks-ce068190-213e-4378-acbe-02eac377c476" = {
    # IMPERATIVE: these are created as a part of adding fido2 decryption to luks partitions described in security.nix
    fido2.credentials = [
      "417637e9f60a961b503abec656dd111c3af116c603dd2797c4abfe913abe091f4c7e4fa5ae1fa974adbb3b37d506ae67"
      "22503dadcf5fb414f38bdf26aefea69d2747bc9f3cfe2ac07e9d2696d35deb758c86264b59baab45892bbb0bc57942b8"
    ];
  };

  # Windows VM configuration
  virtualisation.windows11 = {
    enable = true;
    kvmVariant = "kvm-amd";
    enableWinboat = true;
  };

  environment.sessionVariables = {
    EDITOR = "micro";
  };

  # Enable tpm
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;
  security.tpm2.tctiEnvironment.enable = true;
  users.users.${vars.user}.extraGroups = ["tss"];

  system.stateVersion = "25.05";
}
