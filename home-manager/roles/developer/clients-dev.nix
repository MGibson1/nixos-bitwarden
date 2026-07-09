{
  config,
  vars,
  ...
}: {
  age.secrets = {
    rootCA = {
      # Note, this is also added to security.pki.certificateFiles in the nixos role: development/clients-dev.nix
      file = ../../../secrets/rootCA.pem.age;
      path = "${vars.home-dir}/${vars.user}/.local/share/mkcert/rootCA.pem";
    };
    rootCA-key = {
      file = ../../../secrets/rootCA-key.pem.age;
      path = "${vars.home-dir}/${vars.user}/.local/share/mkcert/rootCA-key.pem";
    };
  };

  # Defaults prefix location to $HOME/.npm
  programs.npm = {
    enable = true;
  };

  home.sessionPath = [
    config.programs.npm.settings.prefix
  ];
}
