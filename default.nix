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

  vendorSha256 = "1f77viwznhwiyk4h0ys60r4dncviqwbfd2kn0zz6axizrj5fy0yi";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
