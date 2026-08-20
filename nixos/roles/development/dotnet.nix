{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.csharprepl

    pkgs.dotnet-sdk_10
    pkgs.dotnetCorePackages.dotnet_10.runtime
    pkgs.dotnetCorePackages.dotnet_10.aspnetcore
    pkgs.dotnet-aspnetcore_10
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
  };
  role.dev.dynamic-libraries = with pkgs; [
    (lib.getLib icu)
  ];
}
