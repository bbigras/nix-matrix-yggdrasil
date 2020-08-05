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

  vendorSha256 = "13nf29hb599z0jsy9jzhrpaq0vmvxxdn0wvyz5cskr6j2bc49bag";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];

  patches = [ ] ++ lib.optional riotX ./riotx.patch;
}
