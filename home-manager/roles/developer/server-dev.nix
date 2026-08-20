{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.sessionPath = [
    "$HOME/.dotnet/tools"
  ];

  home.packages = [
    pkgs.roslyn-ls
  ];

  programs.helix.languages = lib.mkIf (config.programs.helix.enable) {
    language-server.roslyn-language-server = {
      command = "Microsoft.CodeAnalysis.LanguageServer";
      args = [
        "--stdio"
        "--autoLoadProjects"
      ];
    };

    language = [
      {
        name = "c-sharp";
        language-servers = [
          "roslyn-language-server"
          "helix-assist"
        ];
        comment-token = [
          "//"
          "///"
        ];
      }
    ];
  };
}
