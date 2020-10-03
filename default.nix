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

  vendorSha256 = "1cyyfn59z0s7p55v4qld7pi90pmvhnjicaa3sic63php3wq6xq72";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
