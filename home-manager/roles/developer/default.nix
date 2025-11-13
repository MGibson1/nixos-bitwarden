{...}: {
  imports = [
    ../../modules/flatpak.nix

    ./browsers.nix
    ./vscode
  ];

  services.flatpak.packages = [
    "io.dbeaver.DBeaverCommunity" # database client tool
  ];
}
