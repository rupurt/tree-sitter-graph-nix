# tree-sitter-graph-nix

A Nix flake for [tree-sitter-graph](https://github.com/tree-sitter/tree-sitter-graph). Construct graphs from parsed source code

## Custom Flake with Overlay

```nix
# flake.nix
{
  description = "Your Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    tree-sitter-graph-nix.url = "github:rupurt/tree-sitter-graph-nix";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    tree-sitter-graph-nix,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    outputs = flake-utils.lib.eachSystem systems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          tree-sitter-graph-nix.overlay
        ];
      };
    in {
      # packages exported by the flake
      packages = {};

      # nix run
      apps = {};

      # nix fmt
      formatter = pkgs.alejandra;

      # nix develop -c $SHELL
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.tree-sitter-graph-pkgs.default
        ];
      };
    });
  in
    outputs;
}
```

## License

`tree-sitter-graph-nix` is released under the [MIT license](./LICENSE)
