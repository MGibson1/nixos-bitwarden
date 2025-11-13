{pkgs, ...}: {
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions;
      [
        streetsidesoftware.code-spell-checker
        ms-vsliveshare.vsliveshare
        ms-vscode-remote.remote-containers
        ms-vscode.hexeditor
        github.vscode-pull-request-github
        mkhl.direnv
        kamikillerto.vscode-colorize
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      ];
  };
}
