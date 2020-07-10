{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.niv

    # keep this line if you use bash
    pkgs.bashInteractive
  ];
}
