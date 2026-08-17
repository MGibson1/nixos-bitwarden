{
  vars,
  ...
}:
{
  imports = [
    ./gnome.nix
    ../roles/developer
    ../roles/creative
    ./git.nix
    ./nushell
    ./helix.nix
    ./lazygit.nix
    ./zellij

    ../common.nix
  ];

  # need to configure any sessions to source this file on startup
  # it'd be nice if home-manager could do this, but it seems to only support
  # variables declared in the nix files directly with home.sessionVariables
  age.secrets.mgibson-environment-secrets = {
    file = ../../secrets/mgibson-environment-secrets.env.age;
    path = "${vars.home-dir}/${vars.user}/.config/env-secrets.env";
  };

  programs.bash.enable = true;

  home.stateVersion = "25.05";
}
