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

  vendorSha256 = "03ij12nqa9qjhgv3ydmgm5y6czcqgzzlcbhpnmyn7cgkiwgb1vn3";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];

  patches = [ ] ++ lib.optional riotX ./riotx.patch;
}
