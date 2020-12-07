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

    vendorSha256 = "0rw5qd6srhh0p60zdw87z2xi4cpgnbk7v8fy9i3h9qvlbp41wi8h";
    subPackages = [ "cmd/dendrite-demo-yggdrasil" ];
  };

  test = pkgs.nixosTest ./test.nix;
}
