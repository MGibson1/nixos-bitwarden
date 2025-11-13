{pkgs, ...}: {
  services.flatpak.enable = true;

  environment.systemPackages = [
    pkgs.wl-clipboard
  ];
}
