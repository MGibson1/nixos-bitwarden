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

  # 1. nix-shell -p pam_u2f
  # 2. mkdir -p ~/.config/Yubico
  # 3. pamu2fcfg > ~/.config/Yubico/u2f_keys
  # 4. add another hardware key (optional): pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  security.pam.u2f.settings.cue = true;
  # Can use these to decrypt luks partitions
  # export FIDO2_LABEL="/dev/sda2 @ $HOSTNAME"
  # fido2luks credential "$FIDO2_LABEL"
  # fido2luks -i add-key /dev/sda2 <big long thing from the last command>
  environment.systemPackages = [
    pkgs.fido2luks
    pkgs.clevis
  ];
}
