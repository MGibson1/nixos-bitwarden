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
  # Keys live at /etc/pam-u2f/u2f_keys.<username> (root:root 0644) so the hardened
  # polkit-agent-helper@.service (ProtectHome=yes) can still read them. Per-user files
  # via pam_u2f's `%u` expansion (requires the `expand` option below).
  # Replace <username> with your actual username in the commands below.
  # 1. nix-shell -p pam_u2f
  # 2. sudo install -d -m 0755 -o root -g root /etc/pam-u2f
  # 3. pamu2fcfg | sudo tee -a /etc/pam-u2f/u2f_keys.<username>
  # 4. add another hardware key (optional): pamu2fcfg -n emits ":handle,pubkey" meant to be
  #    APPENDED to the existing user's line (colon-separated), not written as a new line.
  #    Easiest: run `pamu2fcfg -n`, then manually paste onto the end of your user's line.
  # 5. sudo chown root:root /etc/pam-u2f/u2f_keys.<username>
  #    sudo chmod 0644 /etc/pam-u2f/u2f_keys.<username>
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
  security.pam.u2f.settings.cue = true;
  security.pam.u2f.settings.expand = true;
  security.pam.u2f.settings.authfile = "/etc/pam-u2f/u2f_keys.%u";

  environment.systemPackages = [
    pkgs.fido2luks
    pkgs.clevis
    pkgs.yubioath-flutter
  ];

  # Lock when yubikey is removed
  services.udev.extraRules = ''
    ACTION=="remove",\
     ENV{ID_BUS}=="usb",\
     ENV{ID_MODEL_ID}=="0407",\
     ENV{ID_VENDOR_ID}=="1050",\
     ENV{ID_VENDOR}=="Yubico",\
     RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';
}
