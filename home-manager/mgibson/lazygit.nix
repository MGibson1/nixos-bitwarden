{ ... }: {
  programs.lazygit = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    settings = {
      git.pagers = [
        {
          pager = "delta --dark --paging=never --features=split-diff";
        }
        {
          pager = "delta --dark --paging=never --features=stack-diff";
        }
      ];
    };
  };
}
