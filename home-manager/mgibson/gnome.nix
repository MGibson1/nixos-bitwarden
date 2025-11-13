{pkgs, ...}: {
  imports = [
    ../roles/gnome
  ];

  vars.home.gnome = {
    pinned = [];
    installed-extensions = with pkgs.gnomeExtensions;
      [
        battery-time-percentage-compact
        caffeine
        ddterm
        easyeffects-preset-selector
        gtile
        night-theme-switcher
        appindicator
        user-themes
        vitals
      ]
      ++ (with pkgs; [
        pomodoro
      ]);
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
      show-extension-notice = false;
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
    # Pomodoro settings
    "org/gnome/shell/extensions/pomodoro" = {
      work-time = 25;
      short-break-time = 5;
      long-break-time = 15;
      long-break-interval = 4;
      enable-sound = false;
      enable-notification = false;
    };
    # Night theme switch settings
    "org/gnome/shell/extensions/nightthemeswitcher/time" = {
      manual-schedule = false;
    };
  };
}
