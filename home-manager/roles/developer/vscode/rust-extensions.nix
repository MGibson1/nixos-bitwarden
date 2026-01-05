{pkgs, ...}: {
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions;
      [
        vadimcn.vscode-lldb
        tamasfe.even-better-toml
        rust-lang.rust-analyzer
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-rust-test-adapter";
          publisher = "swellaby";
          version = "0.11.0";
          sha256 = "sha256-IgfcIRF54JXm9l2vVjf7lFJOVSI0CDgDjQT+Hw6FO4Q=";
        }
      ];
    userSettings = {
      "[rust]" = {
        "editor.tabSize" = 4;
      };
      "[toml]" = {
        "editor.defaultFormatter" = "tamasfe.even-better-toml";
      };
      "rust-analyzer.lens.references.adt.enable" = true;
      "rust-analyzer.lens.references.enumVariant.enable" = true;
      "rust-analyzer.lens.references.method.enable" = true;
      "rust-analyzer.lens.references.trait.enable" = true;
      "lldb.suppressUpdateNotifications" = true;
    };
  };
}
