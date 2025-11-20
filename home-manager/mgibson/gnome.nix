{pkgs, ...}: {
  imports = [
    ../roles/gnome
  ];

  vars.home.gnome = {
    pinned = [
      "firefox.desktop"
      "code.desktop"
      "com.slack.Slack.desktop"
      "org.gnome.Nautilus.desktop"
      "io.dbeaver.DBeaverCommunity.desktop"
    ];
    installed-extensions = with pkgs.gnomeExtensions; [
      battery-time-percentage-compact
      caffeine
      ddterm
      easyeffects-preset-selector
      gtile
      night-theme-switcher
      appindicator
      user-themes
      vitals
    ];
    enabled-extensions = [
      "batterytimepercentagecompact@sagrland.de"
      "caffeine@patapon.info"
      "ddterm@amezin.github.com"
      "eepresetselector@ulville.github.io"
      "gTile@vibou"
      "nightthemeswitcher@romainvigier.fr"
      "appindicatorsupport@rgcjonas.gmail.com"
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "Vitals@CoreCoding.com"
    ];
  };

  # IMPERATIVE: determine new settings with `dconf watch /`
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,close";
    };
    "org/gnome/system/location" = {
      enabled = true; # useful for things like weather and auto-dark mode
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      click-method = "areas";
    };
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
    };
    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
    };
    # ddTerm settings
    "com/github/amezin/ddterm" = {
      ddterm-toggle-hotkey = ["<Control>grave"];
      theme-variant = "dark";
      background-opacity = 0.95;
      panel-icon-type = "none";
      shortcut-win-new-tab = ["<Shift><Control>t"];
    };
    # Night theme switch settings
    "org/gnome/shell/extensions/nightthemeswitcher/time" = {
      manual-schedule = false;
    };
    # Background
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "scaled";
      picture-uri = "file://${builtins.toString ../backgrounds/innovation.png}";
      picture-uri-dark = "file://${builtins.toString ../backgrounds/innovation.png}";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    # Night light color temperature and schedule
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
      night-light-temperature = 3158;
    };
  };
}
