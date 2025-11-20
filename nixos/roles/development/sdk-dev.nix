{pkgs, ...}: {
  imports = [
    ../../modules/nix-ld.nix
  ];

  programs.nix-ld.libraries = with pkgs; [
    gcc
    musl
  ];

  environment.systemPackages = with pkgs; [
    nodejs_22
    rustc
    gcc
    musl
    cargo
    cargo-sort
    cargo-udeps
    cargo-xbuild
    libsecret
  ];
}
