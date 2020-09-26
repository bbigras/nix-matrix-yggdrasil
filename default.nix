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

  vendorSha256 = "1ji5cfps1ciyv1c2lw30zqqplbl5fkxwnxi2cjds1qa3jrvaw2dc";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
