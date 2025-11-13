{pkgs, ...}: {
  home.packages = [
    pkgs.alejandra
    pkgs.nil
  ];

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ];
      userSettings = {
        "colorize.languages" = [
          "nix"
        ];
        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {"command" = ["alejandra"];};
          };
        };
        "nix.formatterPath" = "alejandra";
      };
    };
  };
}
