_: {
  imports = [
    ./starship.nix
  ];

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };
  home.shell.enableNushellIntegration = true;
}
