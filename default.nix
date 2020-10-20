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

  vendorSha256 = "1sbqyvqcv3mdsd5z5nmbmbasccdfs6krmwqgc86z1a21f96ypyw1";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
