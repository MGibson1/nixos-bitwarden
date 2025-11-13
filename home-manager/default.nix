{
  pkgs,
  inputs,
  vars,
  ...
}: {
  home = {
    username = "${vars.user}";
    homeDirectory = "/home/${vars.user}";
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };
}
