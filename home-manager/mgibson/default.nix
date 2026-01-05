{
  pkgs,
  vars,
  ...
}: {
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
        # IMPERATIVE: Generate this key outside of home-manager with
        # ssh-keygen -t ed25519
        signingkey = "${vars.home-dir}/${vars.user}/.ssh/bw-signing.pub";
      };
      # Sign all commits using ssh key
      commit.gpgsign = true;
      tag.gpgsign = true;
      gpg.format = "ssh";
      credential = {
        "https://github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
        "https://gist.github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
      };
      core.excludesFile = "${vars.home-dir}/${vars.user}/.gitignore_global";
    };
  };

  home.file.".gitignore_global".text = ''
    # direnv files and associated flakes
    .direnv
    .envrc
    flake.lock
    flake.nix

    # rust targets
    **/target

    # structurizr internals
    **/.structurizr

    # server dev/helpers should be ignored
    dev/helpers
  '';

  home.stateVersion = "25.05";
}
