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

    # Enable libvirtd daemon for VM management
    # After enabling this module, you need to:
    # 1. Rebuild and reboot your system
    # 2. Create a VM using virt-manager (GUI) or virsh (CLI)
    # 3. When creating the VM, ensure you:
    #    - Select "UEFI x86_64: /usr/share/OVMF/OVMF_CODE.secboot.fd" as firmware
    #    - Add TPM device (Type: Emulated, Model: TIS, Version: 2.0)
    #    - Use the virtio-win ISO for Windows drivers during installation
    #    - Allocate at least 4GB RAM and 64GB disk space
    # 4. During Windows installation, you may need to load the VirtIO drivers:
    #    - Attach the virtio-win ISO as a CDROM
    #    - Click "Load driver" when Windows doesn't see the disk
    #    - Browse to E:\viostor\w11\amd64 (adjust drive letter as needed)
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
      ];

    # Networking for VMs
    networking.firewall.checkReversePath = false; # May be needed for bridged networking

    # Create a polkit rule to allow libvirt management without password
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.libvirt.unix.manage" &&
            subject.isInGroup("libvirtd")) {
          return polkit.Result.YES;
        }
      });
    '';
  };
}
