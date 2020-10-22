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

  vendorSha256 = "0mzadz9vdg7j3s44g1jagb4cshr2im214g6xv974w1xgrybxaiaj";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
