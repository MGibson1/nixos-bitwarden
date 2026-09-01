{ ... }: {
  programs.lazygit = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    settings = {
      git.diffRenderers = [
        {
          command = "delta --dark --paging=never --features=split-diff";
        }
        {
          command = "delta --dark --paging=never --features=stack-diff";
        }
      ];
    };
  };
}
