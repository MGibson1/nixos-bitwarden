{
  inputs,
  vars,
  ...
}: let
  homeDir = "/home/${vars.user}";
in {
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  # Need to create this outside of nixos with ssh-keygen -t ed25519
  age.identityPaths = [
    "${homeDir}/.ssh/id_ed25519"
  ];

  home = {
    username = "${vars.user}";
    homeDirectory = homeDir;
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };
}
