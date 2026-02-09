{pkgs, ...}: {
  # We dont' appear to be able to use agenix to link certificateFiles. These aren't really secret anyway, so exposing through git-crypt is fine
  security.pki.certificateFiles = [
    ../../../secrets/git-crypt/dev.pem
  ];
}
