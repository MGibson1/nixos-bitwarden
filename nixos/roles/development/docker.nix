{
  pkgs,
  vars,
  ...
}: let
  bw-docker-script = pkgs.writeShellScriptBin "bw-docker" ''
    #!/bin/sh
    set -e

    ACTION=$1
    ${pkgs.docker}/bin/docker $ACTION $(${pkgs.docker}/bin/docker ps -a --filter "name=bitwardenserver-" --format "{{.Names}}")
  '';
in {
  virtualisation.docker.enable = true;

  users.users.${vars.user}.extraGroups = ["docker"];

  # helper scripts for managing bitwarden server dev containers
  environment.systemPackages = [
    bw-docker-script
  ];

  # Set node heap allocation to 4GB
  environment.sessionVariables = {
    NODE_OPTIONS = "--max-old-space-size=8192";
  };
}
