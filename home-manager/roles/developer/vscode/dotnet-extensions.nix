{pkgs, ...}: {
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions;
      [
        ms-dotnettools.csharp
        ms-dotnettools.csdevkit
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "user-secrets";
          publisher = "adrianwilczynski";
          version = "2.0.1";
          sha256 = "sha256-wMdQCmoMbh0K2S46A8ZFFqYVsWxnTg+UPZLjneZFWHc=";
        }
        {
          name = "vscode-nuget-package-manager";
          publisher = "jmrog";
          version = "1.1.6";
          sha256 = "sha256-YMTZrFX1ecaubQpKf7gem0ELVo/tfTbeM+yPwzgdVG4=";
        }
      ];
    userSettings = {
      "dotnetAcquisitionExtension.enableTelemetry" = false;
      "csharp.suppressDotnetInstallWarning" = true;
      "dotnet-test-explorer.enableTelemetry" = false;
      "colorize.languages" = [
        "csharp"
        "xml"
      ];
    };
  };
}
