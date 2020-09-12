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

  vendorSha256 = "1x09l8ybkb101ss13rz8plxrswjchy00gi7kjpqn0w91ijyl6n3x";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
