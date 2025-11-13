{
  pkgs,
  vars,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.stable;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      extra-experimental-features = ["flakes" "nix-command"];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      keep-derivations = false; # saves disk space, but looses some traceability
      keep-outputs = false; # increases network, but saves a lot of disk space
      download-buffer-size = 524288000;
      allowed-users = [vars.user "@wheel"];
      trusted-users = ["root" "@wheel"];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        # TODO
      ];
    };
  };
}
