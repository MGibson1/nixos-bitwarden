let
  mgibson_user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVoxVJz/qMl4zUCUEoGLxA896EKbVRg+ZcUK9aKf7uk mgibson@steeltoes_nix";
  users = [mgibson_user];

  steeltoes_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOXq3E2OrMUSav9Qn2AXqr2qcJFRcD/WW1ZQuUDznH2W root@steeltoes";
  hosts = [steeltoes_host];
in {
  "test.age".publicKeys = users ++ hosts;

  # server dev ca cert
  "dev.pem.age".publicKeys = hosts;
}
