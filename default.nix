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

    vendorSha256 = "1yxfqvh81sid04rl270r0yq4cn8hi2hk9g3f2fv3440v5jpsdzrw";
    subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
  };

  test = pkgs.nixosTest ./test.nix;
}
