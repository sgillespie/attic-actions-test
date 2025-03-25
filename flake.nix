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
        # Note: Only works with --impure
        packages.default = 
          pkgs.writeText "example" (builtins.toString builtins.currentTime);

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ attic-client attic-server ];
        };
      });
}
