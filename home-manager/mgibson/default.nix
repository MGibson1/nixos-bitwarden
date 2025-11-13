{pkgs, ...}: {
  imports = [
    ./gnome.nix
    ../roles/developer

    ../default.nix
  ];

  programs.zsh = {
    enable = true;
    history.append = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      #      {
      #        name = "powerlevel10k-config";
      #        src = ./p10k-config;
      #      }
    ];
  };

  home.stateVersion = "25.05";
}
