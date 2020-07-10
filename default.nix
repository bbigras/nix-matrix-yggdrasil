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

  src = fetchFromGitHub {
    owner = "matrix-org";
    repo = "dendride";
    rev = "5eeefdadf8e3881dd7a32559a92be49bd7ddaf47";
    sha256 = "06x648xxzsi9g9jlb1r46m4qkj5lfa3v7kfz5z734kdgqgd9fll9";
  };

  vendorSha256 = "1pvfrhmxbpkx8lbppah7xq0g52gxxg21pngcakj6d1zsam2yv775";
  subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
}
