{
  description = "A Nix flake for tree-sitter-graph. Construct graphs from parsed source code";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    outputs = flake-utils.lib.eachSystem systems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          self.overlay
        ];
      };
    in {
      # packages exported by the flake
      packages = {
        default = pkgs.callPackage ./packages/default.nix {};
      };

      # nix run
      apps = {};

      # nix fmt
      formatter = pkgs.alejandra;

      # nix develop -c $SHELL
      devShells = {};
    });
  in
    outputs
    // {
      # Overlay that can be imported so you can access the packages
      # using tree-sitter-graph-pkgs.overlay
      overlay = final: prev: {
        tree-sitter-graph-pkgs = outputs.packages.${prev.system};
      };
    };
}
