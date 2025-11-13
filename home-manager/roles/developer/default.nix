{...}: {
  imports = [
    ../../modules/flatpak.nix

    ./browsers.nix
    ./vscode
  ];
}
