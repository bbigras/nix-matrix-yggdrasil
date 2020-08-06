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

  vendorSha256 = "14vmjs2gmv8zn5mdgdq01z47h36gkhnzc44qvnivffkrcjcahid4";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];

  patches = [ ] ++ lib.optional riotX ./riotx.patch;
}
