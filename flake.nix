{
  inputs = {
    unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable-lib.url = "github:NixOS/nixpkgs/nixpkgs-unstable?dir=lib";
    nixpkgs.follows = "unstable";
    nixpkgs-lib.follows = "nixpkgs-unstable-lib";

    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "https://flakehub.com/f/numtide/flake-utils/*";
  };

  nixConfig = {
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "tarc.cachix.org-1:wIYVNrWvfOFESyas4plhMmGv91TjiTBVWB0oqf1fHcE="
    ];
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://tarc.cachix.org"
    ];
  };

  outputs = {
    self,
    nixpkgs,
    devenv,
    flake-utils,
    ...
  } @ inputs: let
    inherit (flake-utils.lib) eachSystemMap;

    eachDefaultSystemMap = eachSystemMap (import inputs.systems);
  in {
    packages = eachDefaultSystemMap (system: {
      devenv-up = self.devShells.${system}.default.config.procfileScript;
    });

    devShells = eachDefaultSystemMap (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues self.overlays;
      };
    in {
      default = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [(import ./devenv.nix)];
      };
    });

    overlays = {
      channels = final: prev: {
        unstable = import inputs.unstable {system = prev.system;};
      };
    };
  };
}
