{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nodejs_22
    mkcert
  ];

  security.pki.certificateFiles = [
    ../../../secrets/git-crypt/rootCA.pem
  ];

  programs.npm.enable = true;
}
