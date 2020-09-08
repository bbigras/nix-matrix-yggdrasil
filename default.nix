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

  vendorSha256 = "0198rrmbj011prwpnspqm5yzn4n4r6j19wmrlmp8smv8mlmlys7y";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
