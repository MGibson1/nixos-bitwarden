{pkgs, ...}: {
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

  # IMPERATIVE: how to set up u2f login
  # 1. nix-shell -p pam_u2f
  # 2. mkdir -p ~/.config/Yubico
  # 3. pamu2fcfg > ~/.config/Yubico/u2f_keys
  # 4. add another hardware key (optional): pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  security.pam.u2f.settings.cue = true;

  environment.systemPackages = [
    pkgs.fido2luks
    pkgs.clevis
    pkgs.yubioath-flutter
  ];
}
