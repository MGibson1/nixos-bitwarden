{pkgs, ...}: let
  dbox-claude-script = pkgs.writeShellScriptBin "dbox-claude" ''
    #!/bin/sh
    set -e

    distrobox enter claude -e ~/.local/bin/claude "$@"
  '';
in {
  home.packages = [
    pkgs.claude-code
    dbox-claude-script
  ];

  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions;
      [
        github.copilot
        github.copilot-chat
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "claude-code";
          publisher = "anthropic";
          version = "2.0.37";
          sha256 = "sha256-wXYdMoJhdH5S8EGdELVFbmwrwO7LHgYiEFqiUscQo4Y=";
        }
      ];
    userSettings = {
      "claudeCode.preferredLocation" = "sidebar";
      "claudeCode.claudeProcessWrapper" = "${dbox-claude-script}/bin/dbox-claude";
    };
  };
}
