{
  pkgs,
  inputs,
  ...
}: {
  programs.nix-ld.enable = true;
  programs.nix-ld.package = inputs.nix-ld.packages.${pkgs.stdenv.hostPlatform.system}.nix-ld;
}
