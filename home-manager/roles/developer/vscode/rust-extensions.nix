{pkgs, ...}: {
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions;
      [
        vadimcn.vscode-lldb
        tamasfe.even-better-toml
        rust-lang.rust-analyzer
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
