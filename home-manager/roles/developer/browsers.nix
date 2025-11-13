{pkgs, ...}: {
  services.flatpak.packages = [
    "com.google.Chrome"
    "org.chromium.Chromium"
    "com.microsoft.Edge"
    "com.opera.Opera"
    "com.vivaldi.Vivaldi"
    "com.brave.Browser"
    "org.torproject.torbrowser-launcher"
    "org.mozilla.firefox"
  ];

  # home.package = [
  #   # Doesn't appear to be released via flatpak
  #   pkgs.tor-browser
  # ];
}
