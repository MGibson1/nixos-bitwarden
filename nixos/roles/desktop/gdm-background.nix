{
  config,
  lib,
  ...
}: let
  cfg = config.vars.gdm;
  inherit (lib) mkIf mkOption types;
in {
  options.vars.gdm.background = mkOption {
    type = types.nullOr types.path;
    default = null;
    description = "Optional path to use for a gdm background";
  };

  config = mkIf (cfg.background != null) {
    programs.dconf.profiles.gdm.databases = [
      {
        settings."org/gnome/desktop/background" = {
          picture-uri = "file://${builtins.toString cfg.background}";
        };
      }
    ];
  };
}
