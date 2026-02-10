{
  lib,
  pkgs,
  vars,
  ...
}: let
  inherit (lib) mkIf;
  logo = if vars.boot-splash-svg != null then vars.boot-splash-svg else vars.boot-splash-png;
in {
  config = mkIf (logo != null) {
    nixpkgs = let
      override = pkgs.replaceVars ./org.gnome.login-screen.gschema.override {
        icon = builtins.toString logo;
      };
    in {
      overlays = [
        (self: super: {
          gdm = super.gdm.overrideAttrs (gfinal: gprev: {
            preInstall = ''
              install -D ${override} "$DESTDIR/$out/share/glib-2.0/schemas/org.gnome.login-screen.gschema.override"
            '';
          });
        })
      ];
    };
  };
}
