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
    settings = {
      user = {
        name = "Matt Gibson";
        email = "mgibson@bitwarden.com";
        # Generate this key outside of home-manager with
        # ssh-keygen -t ed25519
        signingkey = "/home/mgibson/.ssh/bw-signing.pub";
      };
      # Sign all commits using ssh key
      commit.gpgsign = true;
      tag.gpgsign = true;
      gpg.format = "ssh";
    };
  };

  home.stateVersion = "25.05";
}
