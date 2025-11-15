{pkgs, ...}: {
  imports = [
    ./gnome.nix
    ../roles/developer
    ../roles/creative

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
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };

  programs.git = {
    enable = true;
    userName = "Matt Gibson";
    userEmail = "mgibson@bitwarden.com";
    extraConfig = {
      # Sign all commits using ssh key
      commit.gpgsign = true;
      tag.gpgsign = true;
      gpg.format = "ssh";
      # Generate this key outside of home-manager with
      # ssh-keygen -t ed25519
      user.signingkey = "/home/mgibson/.ssh/bw-signing.pub";
    };
  };

  home.stateVersion = "25.05";
}
