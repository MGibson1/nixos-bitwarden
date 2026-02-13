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
    pkgs.dotnet-sdk_10
    pkgs.dotnetCorePackages.dotnet_10.runtime
    pkgs.dotnetCorePackages.dotnet_10.aspnetcore
    pkgs.dotnet-aspnetcore_10
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_8}/share/dotnet";
  };
  role.dev.dynamic-libraries = with pkgs; [
    (lib.getLib icu)
  ];
}
