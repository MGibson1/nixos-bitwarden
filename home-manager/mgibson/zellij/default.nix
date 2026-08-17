{pkgs, ...}: {
  home.packages = with pkgs; [
    zellij

    alacritty # terminal set up for zellij session
  ];

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
