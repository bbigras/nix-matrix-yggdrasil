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

    vendorSha256 = "0n90s6vd9fi16qn866nia1iyr8862rf4adsiqqv17ks3843jqdy6";
    subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
  };

  test = pkgs.nixosTest ./test.nix;
}
