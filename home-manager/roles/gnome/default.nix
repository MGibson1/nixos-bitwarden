{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.vars.home.gnome;
in {
  options.vars.home.gnome = {
    pinned = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of .desktop applications to pin to the dock";
    };

    installed-extensions = mkOption {
      # type = types.listOf types.str;
      default = [];
      description = "List of extension packages to install";
    };

    enabled-extensions = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "List of enabled extensions by their extension Id. use dconf watch / and toggle the extension to determine";
    };
  };

  config = {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = cfg.enabled-extensions;

        favorite-apps = cfg.pinned;
      };
    };

    home.packages = cfg.installed-extensions;
  };
}
