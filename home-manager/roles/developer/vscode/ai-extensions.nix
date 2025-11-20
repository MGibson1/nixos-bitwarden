{pkgs, ...}: {
  home.packages = [
    pkgs.claude-code
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
    };
  };
}
