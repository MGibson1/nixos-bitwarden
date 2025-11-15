{pkgs, ...}: {
  # Enable fprint
  services.fprintd.enable = true;

  # Hack to fix fprint after suspend losing the device
  systemd.services.fprintd-restart-after-suspend = {
    description = "Restart fprintd after suspend";
    after = ["sleep.target" "suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];
    wantedBy = ["sleep.target" "suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl restart fprintd.service";
    };
  };
  # Another hack to kill fprintd before sleep to avoid issues
  systemd.services.fprintd-kill-before-sleep = {
    description = "Kill fprintd before sleep";
    before = ["sleep.target" "suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];
    wantedBy = ["sleep.target" "suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.psmisc}/bin/killall fprintd";
    };
  };

  #   /etc/systemd/system/kill-fprintd.service

  # [Unit]
  # Description=Kill fprintd before sleep
  # Before=sleep.target

  # [Service]
  # ExecStart=killall fprintd

  # [Install]
  # WantedBy=sleep.target
}
