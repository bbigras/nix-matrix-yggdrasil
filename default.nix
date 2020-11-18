let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    overlays = [
      (_: _: { inherit sources; })
    ];
  };
in
with pkgs;

{
  main = buildGoModule {
    name = "nix-matrix-yggdrasil";

    src = fetchFromGitHub { inherit (sources.dendrite) owner repo rev sha256; };

    vendorSha256 = "04kj8739aj3x10bvmsva9306j19axcyv4ij4dgawks7a8wd3hnw7";
    subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
  };

  test = pkgs.nixosTest ./test.nix;
}
