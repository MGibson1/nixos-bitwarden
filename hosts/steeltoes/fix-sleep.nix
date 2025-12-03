# Modified from https://wiki.archlinux.org/title/Lenovo_ThinkPad_P16s_(AMD)_Gen_2#Hang_on_resume
# and https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Combined_sleep/resume_unit
# Addressing Thunderbolt 3 power state issues causing resume hangs
{...}: {
  # Prevent Thunderbolt 3 controller from entering deep power states that cause resume issues
  # Vendor 0x8086 = Intel, Device 0x15e8 = JHL6540 Thunderbolt 3 Bridge
  services.udev.extraRules = ''
    SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0x15e8", ATTR{power/control}="on"
  '';

  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  # Commented out - these break Thunderbolt on resume
  # systemd.services.fix-thunderbolt-sleep = {
  #   description = "Unbind Thunderbolt 3 controller before suspend";
  #   wantedBy = ["sleep.target"];
  #   before = ["sleep.target"];
  #
  #   unitConfig = {
  #     StopWhenUnneeded = true;
  #   };
  #
  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     ExecStart = pkgs.writeShellScript "fix-thunderbolt-sleep" ''
  #       # Unbind Thunderbolt bridges that are failing to resume
  #       for device in /sys/bus/pci/drivers/pcieport/0000:62:*; do
  #         if [ -e "$device" ]; then
  #           echo "$(basename $device)" > /sys/bus/pci/drivers/pcieport/unbind || true
  #         fi
  #       done
  #
  #       # Also try removing thunderbolt module
  #       ${pkgs.kmod}/bin/modprobe -r thunderbolt || true
  #     '';
  #     # This ExecStop runs when sleep.target is deactivated (on resume)
  #     ExecStop = pkgs.writeShellScript "fix-thunderbolt-resume" ''
  #       # Reload thunderbolt module
  #       ${pkgs.kmod}/bin/modprobe thunderbolt || true
  #
  #       # Rescan PCI bus to rebind devices
  #       echo 1 > /sys/bus/pci/rescan || true
  #     '';
  #   };
  # };
}
