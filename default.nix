{ riotX ? false }:
let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    overlays = [
      (_: _: { inherit sources; })
    ];
  };
in
with pkgs;

buildGoModule {
  name = "nix-matrix-yggdrasil";

  src = fetchFromGitHub { inherit (sources.dendrite) owner repo rev sha256; };

  vendorSha256 = "0w939lnn9yqg0lray23rljqsyjsix6jpp56mq1wcwfvfqa9vnk3n";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];

  patches = [ ] ++ lib.optional riotX ./riotx.patch;
}
