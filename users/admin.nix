{
  config,
  lib,
  vars,
  ...
}: let
in {
  # age.secrets."${vars.user}_password_hash" = {
  #   file = ../secrets/${vars.user}_password_hash.age;
  # }

  users.defaultUserShell = vars.default-shell;
  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    home = "/home/${vars.user}";
    createHome = true;
    # hashedPasswordFile = age.secrets."${vars.user}_password_hash".path;
  };
}
