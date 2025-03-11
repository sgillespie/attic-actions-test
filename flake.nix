{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, utils, ... }@inputs:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.pkgsCross.aarch64-multiplatform-musl.cowsay;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ attic-client attic-server ];
        };
      });
}
