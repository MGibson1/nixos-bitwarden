{
  config,
  lib,
  pkgs,
  vars,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf types optionals;
  cfg = config.virtualisation.windows11;
in {
  options.virtualisation.windows11 = {
    enable = mkEnableOption "Windows 11 VM support with proper UEFI, TPM 2.0, and performance optimizations";

    user = mkOption {
      type = types.str;
      default = vars.user;
      description = "User to grant VM access permissions";
    };

    kvmVariant = mkOption {
      type = types.enum ["kvm-amd" "kvm-intel"];
      description = "KVM kernel module variant for hardware virtualization (kvm-amd or kvm-intel)";
    };

    enableGUI = mkOption {
      type = types.bool;
      default = true;
      description = "Install virt-manager GUI for VM management";
    };

    enableGpuPassthrough = mkOption {
      type = types.bool;
      default = false;
      description = "Enable VFIO for GPU passthrough (requires additional configuration)";
    };

    enableLookingGlass = mkOption {
      type = types.bool;
      default = false;
      description = "Install Looking Glass for low-latency GPU passthrough display";
    };
  };

  config = mkIf cfg.enable {
    # Enable KVM kernel module for hardware virtualization
    boot.kernelModules =
      [cfg.kvmVariant]
      ++ optionals cfg.enableGpuPassthrough [
        "vfio"
        "vfio_iommu_type1"
        "vfio_pci"
        "vfio_virqfd"
      ];

    boot.kernelParams = optionals cfg.enableGpuPassthrough [
      "amd_iommu=on"
      "iommu=pt"
    ];

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        # Enable software TPM 2.0 support (required for Windows 11)
        # The TPM is automatically set up by libvirt when you add a TPM device to your VM
        swtpm.enable = true;
        # Run QEMU as the user for better permissions
        runAsRoot = false;
        verbatimConfig = ''
          user = "${cfg.user}"
          group = "libvirtd"
        '';
        vhostUserPackages = [pkgs.virtiofsd];
      };
    };

    # Enable SPICE USB redirection for USB passthrough
    virtualisation.spiceUSBRedirection.enable = true;

    # Add user to libvirtd group for VM management permissions
    users.users.${cfg.user}.extraGroups = ["libvirtd" "kvm"];

    # Install required packages
    environment.systemPackages = with pkgs;
      [
        # Core virtualization tools
        qemu_kvm
        libvirt

        # VirtIO drivers ISO for Windows
        virtio-win

        # Management tools
        virtiofsd # Shared folder support
      ]
      ++ optionals cfg.enableGUI [
        virt-manager # Full-featured GUI
        virt-viewer # Lightweight VM viewer
      ]
      ++ optionals cfg.enableLookingGlass [
        looking-glass-client
      ]
      ++ [
        freerdp # RDP client for remote connections
      ];

    # Networking for VMs
    networking.firewall.checkReversePath = false; # May be needed for bridged networking
  };
}
