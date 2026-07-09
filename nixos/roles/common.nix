{inputs, ...}: {
  services.flatpak.enable = true;
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  services.flatpak.packages = [
    "com.bitwarden.desktop"
  ];

  # Force keyctl instead of memfd_secret so the kernel can hibernate.
  # https://github.com/bitwarden/clients/blob/main/apps/desktop/desktop_native/core/src/secure_memory/secure_key/mod.rs
  services.flatpak.overrides."com.bitwarden.desktop".Environment.SECURE_KEY_CONTAINER_BACKEND = "mlock";

  # polkit policy for system auth: https://bitwarden.com/help/biometrics/#tab-linux-2vCWb5iFg4OqKS0B2xXpqW
  # Source: https://github.com/bitwarden/clients/blob/main/apps/desktop/resources/com.bitwarden.desktop.policy
  environment.etc."polkit-1/actions/com.bitwarden.Bitwarden.policy".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE policyconfig PUBLIC
     "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN"
     "http://www.freedesktop.org/standards/PolicyKit/1.0/policyconfig.dtd">

    <policyconfig>
        <action id="com.bitwarden.Bitwarden.unlock">
          <description>Unlock Bitwarden</description>
          <message>Authenticate to unlock Bitwarden</message>
          <defaults>
            <allow_any>no</allow_any>
            <allow_inactive>no</allow_inactive>
            <allow_active>auth_self</allow_active>
          </defaults>
        </action>
    </policyconfig>
  '';

  security.pam.services = {
    polkit-1.u2fAuth = true;
  };

  # polkit 127 hardened polkit-agent-helper@.service with PrivateDevices=yes and a strict
  # DeviceAllow list, which blocks /dev/urandom (needed for OpenSSL RAND_bytes) and /dev/hidraw*
  # (the Yubikey). We keep deny-by-default and only allow the specific devices pam_u2f needs.
  # ProtectHome=yes is preserved by relocating u2f_keys to /etc/pam-u2f (see modules/security.nix).
  # https://github.com/Yubico/pam-u2f/issues/389
  systemd.services."polkit-agent-helper@" = {
    overrideStrategy = "asDropin";
    serviceConfig = {
      PrivateDevices = false; # override to allow hidraw devices
      DevicePolicy = "strict"; # matches upstream
      DeviceAllow = [
        "/dev/null rw" # matches upstream
        "/dev/urandom r" # needed by OpenSSL RAND_bytes
        "char-hidraw rw" # needed by libfido2 to talk to the Yubikey
      ];
    };
  };
}
