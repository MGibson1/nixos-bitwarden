{...}: {
  imports = [
    ../../modules/flatpak.nix

    ./browsers.nix
    ./vscode

    ./clients-dev.nix
    ./server-dev.nix
  ];

  services.flatpak.packages = [
    "io.dbeaver.DBeaverCommunity" # database client tool
  ];
}
