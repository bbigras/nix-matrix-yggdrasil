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

  vendorSha256 = "0y98kcd5hzp8ymn5mnps57l43zcsj5m5j7iwkaj4slmiixf79mq5";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
