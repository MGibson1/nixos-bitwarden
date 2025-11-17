{pkgs, ...}: {
  imports = [
    ./docker.nix
    ./dotnet.nix
    ./openssh.nix

    ./clients-dev.nix
    ./server-dev.nix
  ];

  environment.systemPackages = with pkgs; [
    curl # network fetch
    wget # network fetch

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
}
