{pkgs, ...}: {
  imports = [
    ./ai-extensions.nix
    ./dotnet-extensions.nix
    ./git-extensions.nix
    ./nix-extensions.nix
    ./rust-extensions.nix
    ./tailwind-extensions.nix
    ./typescript-extensions.nix
    ./util-extensions.nix
  ];

  programs.vscode = {
    enable = true;
    profiles.default = {
      keybindings = [
        {
          key = "ctrl+t ctrl+f";
          command = "workbench.action.terminal.focus";
        }
        {
          key = "ctrl+t ctrl+s";
          command = "workbench.action.terminal.split";
          when = "terminalFocus && terminalProcessSupported || terminalFocus && terminal WebExtensionContributedProfile";
        }
        {
          key = "ctrl+alt+meta+left";
          command = "workbench.action.moveEditorToPreviousGroup";
        }
        {
          key = "ctrl+alt+meta+right";
          command = "workbench.action.moveEditortoNextGroup";
        }
      ];
      userSettings = {
        "update.mode" = "none";
        "telemetry.telemetryLevel" = "off";
        "telemetry.feedback.enabled" = false;
        "debug.toolBarLocation" = "docked";
        "editor.fontFamily" = "'JetBrains Mono', 'FiraCode Nerd Font'";
        "editor.renderWhitespace" = "all";
        "editor.formatOnSave" = true;
        "extensions.ignoreRecommendations" = true;
        "workbench.remoteIndicator.ignoreRecommendations" = true;
        "files.insertFinalNewline" = true;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "scm.showHistoryGraph" = false;
        "terminal.integrated.fontSize" = 16;
        "window.commandCenter" = true;
        "window.restoreWindows" = "all";
        "window.titleBarStyle" = "custom";
        "workbench.commandPalette.experimental.suggestCommands" = true;
        "workbench.colorTheme" = "Default Dark+";
        "diffEditor.ignoreTrimWhitespace" = false;
        "editor.tabSize" = 2;
      };
    };
  };
}
