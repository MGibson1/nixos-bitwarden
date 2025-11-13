{
  vars,
  inputs,
  ...
}: {
  imports = [
    ./audio.nix
    ../../nixos/printing.nix

    ../../roles/desktop
    ../../roles/desktop/gnome.nix
    ../../roles/development

    ./hardware-configuration.nix

    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p16s-amd-gen4
    ../default.nix
  ];

  vars.user = "mgibson";

  home-manager = {
    users.${vars.user}.imports = [
      ../../home-manager/mgibson
    ];
  };

  networking.hostName = "steeltoes";

  # Enable fprint
  services.fprintd.enable = true;

  environment.sessionVariables = {
    EDITOR = "micro";
  };

  system.stateVersion = "25.05";
}
