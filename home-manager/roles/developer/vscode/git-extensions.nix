{pkgs, ...}: {
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      donjayamanne.githistory
      mhutchie.git-graph
    ];
    userSettings = {
      "gitlens.telemetry.enabled" = false;
      "gitlengs.advanced.blame.customArguments" = [
        "--ignore-revs-file"
        ".git-blame-ignore-revs"
      ];
      "gitlens.showWelcomeOnInstall" = false;
      "gitlens.showWhatsNewAfterUpdate" = false;
      "gitlens.plusFeatures.enabled" = false;
      "gitlens.virtualRepositories.enabled" = false;
    };
  };
}
