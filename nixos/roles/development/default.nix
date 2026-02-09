{
  config,
  pkgs,
  lib,
  ...
}: let
  mkOption = lib.mkOption;
in {
  imports = [
    ./docker.nix
    ./dotnet.nix
    ./openssh.nix

    ./clients-dev.nix
    ./sdk-dev.nix
    ./server-dev.nix
  ];

  options = {
    role.dev.dynamic-libraries = mkOption {
      type = with lib.types; listOf package;
      default = [];
      description = "Additional libraries to include in the development environment.";
    };
  };

  config = {
    # Set libraries for dynamic loading
    environment.variables.LD_LIBRARY_PATH = lib.makeLibraryPath config.role.dev.dynamic-libraries;

    environment.systemPackages = with pkgs; [
      curl # network fetch
      wget # network fetch

      gh # github cli for auth
      gitFull # git
      git-crypt # git

      htop # system management
      pciutils # system information
      usbutils # system information
      psmisc # system management like killall, pstree, fuser
      util-linux

      helix # editor
      vim # editor
      micro # editor
      (aspellWithDicts (dicts: with dicts; [en en-computers en-science])) # Spelling dictionaries

      unzip # file management
      fd # file search
      jq # cli json manipulation
      ripgrep # search
      bat # print file contents nicely
      eza # modern ls

      bc # terminal calculator
      hyperfine # benchmarking
      watch # rerun commands on a schedule

      sshfs # ssh file mounting

      powershell # cross platform shell necessary for bitwarden dev scripts
    ];
  };
}
