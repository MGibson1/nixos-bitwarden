{vars, ...}: {
  age.secrets = {
    rootCA = {
      # Note, this is also added to security.pki.certificateFiles in the nixos role: development/clients-dev.nix
      file = ../../../secrets/rootCA.pem.age;
      # TODO: grab /home/${vars.user} from config somehow
      path = "/home/${vars.user}/.local/share/mkcert/rootCA.pem";
    };
    rootCA-key = {
      file = ../../../secrets/rootCA-key.pem.age;
      # TODO: grab /home/${vars.user} from config somehow
      path = "/home/${vars.user}/.local/share/mkcert/rootCA-key.pem";
    };
  };
}
