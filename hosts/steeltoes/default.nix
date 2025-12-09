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
  vars.home-dir = "/storage/home";
  vars.gdm.background = ../../home-manager/backgrounds/innovation.png;
  vars.default-shell = pkgs.nushell;

  # Use latest kernel, not latest lts
  boot.kernelPackages = pkgs.linuxPackages_latest;

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
  boot.resumeDevice = "/dev/disk/by-uuid/4b728eb2-d411-4085-8fc2-e5810c4ef5a3";
  # IMPERATIVE: `sudo filefrag /var/lib/swapfile | head` and grab the physical offset of the first extent
  boot.kernelParams = ["resume_offset=2977792"];

  # setup luks fido2 unlocking
  boot.initrd = {
    systemd.enable = true;
    luks.fido2Support = false; # handled by systemd
    luks.devices."luks-ce068190-213e-4378-acbe-02eac377c476" = {
      # IMPERATIVE: set up a fido2 credential on this luks device
      # Optionally, create a fido2 pin using something like yubioath-flutter
      # then, create the luks entry with:
      # `sudo systemd-cryptenroll /dev/nvme0n1p2 --fido2-device=auto --fido2-with-user-presence=false --fido2-with-user-verification=true`
      crypttabExtraOpts = [
        "fido2-device=auto"
      ];
    };
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
