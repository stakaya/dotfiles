{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        homeConfig = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          modules = [ ./neovim.nix ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            homeConfig.activationPackage
          ];
        };
        homeConfigurations."user" = homeConfig;
      }
    );
}
