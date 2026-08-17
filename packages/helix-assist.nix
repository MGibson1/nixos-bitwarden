{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "helix-assist";
  version = "1.0.12";

  src = fetchFromGitHub {
    owner = "leona";
    repo = "helix-assist";
    tag = "v${version}";
    hash = "sha256-pAbWGKV0Xu1wFSven4n32eq88fLeIbyA5imnlAFt+0c=";
  };

  # go.mod declares no external dependencies
  vendorHash = null;

  subPackages = ["cmd/helix-assist"];

  ldflags = ["-s" "-w" "-X main.Version=${version}"];

  meta = {
    description = "Code assistant language server for Helix with support for OpenAI/Anthropic";
    homepage = "https://github.com/leona/helix-assist";
    license = lib.licenses.mit;
    mainProgram = "helix-assist";
  };
}
