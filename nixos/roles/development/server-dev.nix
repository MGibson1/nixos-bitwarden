{
  config,
  vars,
  ...
}: {
  age.secrets.dev-cer = {
    file = ../../../secrets/dev.pem.age;
    owner = vars.user;
    group = "users";
    mode = "770";
    path = "/etc/ssl/certs/dev.pem";
    symlink = false;
  };

  # TODO: get automated cert working with security.pki.certificateFiles
  # Currently there are complaints finding the agenix managed cert
  # This doesn't _have_ to be encrypted, but the cert is currently not public.
}
