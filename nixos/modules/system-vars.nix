{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.vars = {
    user = mkOption {
      type = types.str;
      default = "admin";
      description = "The admin and primary user for the system";
      example = "mgibson";
    };
    timezone = mkOption {
      type = types.str;
      default = "America/Los_Angeles";
      description = "the system timezone";
      example = "Europe/London";
    };
    locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = "The system locale";
      example = "en_US.UTF-8";
    };
    keyboard = mkOption {
      type = types.submodule {
        options = {
          layout = mkOption {
            type = types.str;
            default = "us";
            description = "The keyboard layout";
            example = "us";
          };

          variant = mkOption {
            type = types.str;
            default = "";
            description = "The keyboard variant";
            example = "dvorak";
          };
        };
      };
      default = {};
      description = "X11 keyboard configuration";
    };
    default-shell = mkOption {
      type = types.package;
      default = pkgs.bash;
      description = "The default user shell to apply";
    };
  };

  config._module.args.vars = config.vars;
}
