{ pkgs, ... }: {
  home.packages = with pkgs; [
    alacritty # terminal set up for zellij session
  ];

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    # plugins = with pkgs.zellijPlugins; [
    #   autolock
    # ];
  };

  # terminal file namager
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    shellWrapperName = "y";
  };

  home.file.".config/alacritty/alacritty.toml".text = ''
    [window]
    decorations = "None"

    [terminal.shell]
    program = "zellij"
    args = ["-l", "welcome"]
  '';

  home.file.".config/zellij/config.kdl".source = ./config.kdl;
  home.file.".config/zellij/layouts/default.kdl".source = ./layouts/default.kdl;
}
