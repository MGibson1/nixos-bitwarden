{config, ...}: {
  age.secrets.dev-cer = {
    files = ../../../secrets/dev.pem.age;
  };

  security.pki.certificateFiles = [
    config.age.secrets.dev-cer.path
  ];
}
