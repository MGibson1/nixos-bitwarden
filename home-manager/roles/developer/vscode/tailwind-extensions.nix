{pkgs, ...}: {
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions; [
      bradlc.vscode-tailwindcss
    ];
    userSettings = {
      "colorize.languages" = [
        "css"
        "sass"
        "scss"
        "less"
        "postcss"
        "sss"
        "stylus"
        "svg"
      ];
    };
  };
}
