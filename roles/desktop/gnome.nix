{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.services.my.gnome;
in {
  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "gnome";
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    cheese # photo booth
    epiphany # web viewer
    geary # email reader
    yelp # help
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    gnome-photos
    gnome-tour
    gnome-contacts
    gnome-initial-setup
    gnome-calendar
    gnome-connections
    gnome-clocks
    gnome-logs
    gnome-maps
    gnome-music
    gnome-weather
  ];

  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-browser-connector
    numix-gtk-theme
    numix-icon-theme
    numix-cursor-theme

    # vms
    gnome-boxes
    libvirt
    qemu

    firefox
  ];

  virtualisation.spiceUSBRedirection.enable = true;

  # Hardcode themes and icons locations to FHS for things like flatpak
  system.fsPackages = [pkgs.bindfs];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = ["ro" "resolve-symlinks" "x-gvfs-hide"];
    };
    aggregated = pkgs.buildEnv {
      name = "system-themed-and-icons";
      paths = with pkgs; [
        numix-gtk-theme
        numix-icon-theme
        numix-cursor-theme
      ];
      pathsToLink = ["/share/themes" "/share/icons"];
    };
  in {
    # Create an FHS mount to support flatpak host icons/themes
    "/usr/share/icons" = mkRoSymBind "${aggregated}/share/icons";
    "/usr/share/themes" = mkRoSymBind "${aggregated}/share/themes";
  };
}
