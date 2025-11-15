{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.dotnet-sdk_8
    pkgs.dotnetCorePackages.dotnet_8.runtime
    pkgs.dotnetCorePackages.dotnet_8.aspnetcore
    pkgs.dotnet-aspnetcore_8
    pkgs.dotnet-sdk_9
    pkgs.dotnetCorePackages.dotnet_9.runtime
    pkgs.dotnetCorePackages.dotnet_9.aspnetcore
    pkgs.dotnet-aspnetcore_9
  ];
}
