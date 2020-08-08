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

  vendorSha256 = "0gmxb5fr28cdmq0vfy0xppsj47868ybsml9x9y5sazpcw3xl8drg";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];

  patches = [ ] ++ lib.optional riotX ./riotx.patch;
}
