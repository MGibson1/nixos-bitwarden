{ pkgs, vars, ... }: {
  home.packages = [
    pkgs.delta # git diff pager
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

      core = {
        excludesFile = "${vars.home-dir}/${vars.user}/.gitignore_global";
        pager = "delta";
      };

      init.defaultBranch = "main";

      delta = {
        feature = "split-diff stack-diff";
        navigate = true;
        "split-diff" = {
          side-by-side = true;
        };
        "stack-diff" = {
          side-by-side = false;
        };
      };
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

    # claude local files
    **/.claude/settings.local.json
    CLAUDE.local.md
  '';
}
