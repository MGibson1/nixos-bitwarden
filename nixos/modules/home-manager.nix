{
  inputs,
  vars,
  ...
}: {
  home-manager = {
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit inputs vars;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
