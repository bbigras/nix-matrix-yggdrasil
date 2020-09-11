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

  vendorSha256 = "1vb7z3wz9cvpx7r6qalx1xjvvv7aah1k39hq2y1fl0v3xfydgmqa";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
