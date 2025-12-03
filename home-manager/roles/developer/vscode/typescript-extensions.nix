{pkgs, ...}: {
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions;
      [
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-jest";
          publisher = "orta";
          version = "5.2.3";
          sha256 = "sha256-cPHwBO7dI44BZJwTPtLR7bfdBcLjaEcyLVvl2Qq+BgE=";
        }
      ];
    userSettings = {
      "typescript.updateImporsOnFileMove.enabled" = "always";
      "javascript.format.semicolons" = "insert";
      "typescript.format.semicolons" = "insert";
      "typescript.referencesCodeLens.enabled" = true;
      "typescript.referencesCodeLens.showOnAllFunctions" = true;
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[html]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "jest.runMode" = "watch";
      "jest.shell" = "bash";
      "jest.coverageFormatter" = "GutterFormatter";
    };
  };
}
