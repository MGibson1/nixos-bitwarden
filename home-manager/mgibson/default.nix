{pkgs, ...}: {
  imports = [
    ./gnome.nix
    ../roles/developer
    ../roles/creative
    ./nushell

    ../default.nix
  ];

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
