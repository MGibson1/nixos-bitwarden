let
  # IMPERATIVE: add user key here when a new one is made
  mgibson_user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKrZpj66GbyYUpIsvFaAeWlCJjdftYTJDUDjTmNsknKR mgibson@steeltoes";
  users = [mgibson_user];

  # IMPERATIVE: add system key here when a new one is made
  steeltoes_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOXq3E2OrMUSav9Qn2AXqr2qcJFRcD/WW1ZQuUDznH2W root@steeltoes";
  hosts = [steeltoes_host];

  all = users ++ hosts;
in {
  "test.age".publicKeys = all;

  # web dev ca cert
  "rootCA.pem.age".publicKeys = all;
  "rootCA-key.pem.age".publicKeys = all;

  # mgibson
  "mgibson-environment-secrets.env.age".publicKeys = [mgibson_user steeltoes_host];
}
