let
  mgibson_user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKrZpj66GbyYUpIsvFaAeWlCJjdftYTJDUDjTmNsknKR mgibson@steeltoes";
  users = [mgibson_user];

  steeltoes_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOXq3E2OrMUSav9Qn2AXqr2qcJFRcD/WW1ZQuUDznH2W root@steeltoes";
  hosts = [steeltoes_host];
in {
  "test.age".publicKeys = users ++ hosts;

  # web dev ca cert
  "rootCA.pem.age".publicKeys = hosts ++ users;
  "rootCA-key.pem.age".publicKeys = hosts ++ users;
}
