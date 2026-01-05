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
      auto-move-windows
      bluetooth-battery-meter
      battery-time-percentage-compact
      caffeine
      ddterm
      gtile
      night-theme-switcher
      appindicator
      user-themes
      vitals
      wellbeing-toggle
    ];
    enabled-extensions = [
      "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
      "batterytimepercentagecompact@sagrland.de"
      "Bluetooth-Battery-Meter@maniacx.github.com"
      "caffeine@patapon.info"
      "ddterm@amezin.github.com"
      "gTile@vibou"
      "nightthemeswitcher@romainvigier.fr"
      "appindicatorsupport@rgcjonas.gmail.com"
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "Vitals@CoreCoding.com"
      "wellbeingtoggle@m51.io"
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
    # Wait a little longer than usual to turn off screen, this is for wellbeing
    "org/gnome/desktop/session" = {
      idle-delay = 480;
    };
    # Auto Move Windows settings
    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = ["com.slack.Slack.desktop:1" "firefox.desktop:3" "code.desktop:2"];
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
