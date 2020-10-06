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

  vendorSha256 = "0pk4mh599yy617laaig2yjlx85jk9zjzd7vjsvg37wjp2qp7j3rr";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
