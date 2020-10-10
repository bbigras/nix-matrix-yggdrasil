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

  patches = [ ./update-quic-go.patch ];

  vendorSha256 = "027fdkv9a5whsrkhyzrj7w414x6qiis6rzq56hjxzgcsk443x97p";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
