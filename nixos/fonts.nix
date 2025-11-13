{pkgs, ...}: {
  enableDefaultPackages = true;
  fontDir.enable = true;

  packages = with pkgs;
    [
      corefonts
      dejavu_fonts
      font-awesome
      fira-code
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra
      powerline-fonts
      meslo-lgs-nf
    ]
    # All nerd-fonts
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
