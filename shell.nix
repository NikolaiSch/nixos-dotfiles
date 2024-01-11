{ pkgs ? import <nixpkgs> { } }:
let
  mynode = pkgs.nodejs-14_x;
in
pkgs.stdenv.mkDerivation {
  name = "my-shell";
  packages = [  ];
  shellHook = "";
  buildInputs = [ mynode ];
}
