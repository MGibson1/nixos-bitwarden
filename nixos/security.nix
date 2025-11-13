{
  boot.kernel.sysctl = {
    # The Magic SysRq key is a key combo that allows users connected to the
    # system console of a Linux kernel to perform some low-level commands.
    # Disable it, since we don't need it, and is a potential security concern.
    "kernel.sysrq" = 0;

    ## TCP hardening
    # Prevent bogus ICMP errors from filling up logs.
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    # TODO
  };
  boot.kernelModules = ["tcp_bbr"];

  # So we don't have to do this later...
  security.acme = {
    acceptTerms = true;
    defaults.email = "snscoqk@duck.com";
  };
  services.fail2ban = {
    enable = true;
    bantime = "1h";
    maxretry = 1;
    ignoreIP = [
      "192.168.0.0/16"
      "172.16.0.0/12"
      "10.0.0.0/8"
    ];
    jails.DEFAULT = {
      settings = {
        findtime = 100000;
        mode = "aggressive";
      };
    };
  };
  services.gnome.gnome-keyring.enable = true;
}
