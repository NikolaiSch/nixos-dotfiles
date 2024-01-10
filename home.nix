{ ... }:

{
  imports = [
    <home-manager/nixos>
    ./modules/ui.nix
    ./modules/kitty.nix
    ./modules/cli.nix
    ./modules/nvim.nix
    ./modules/devtools.nix
  ];

  home-manager.users.vii = { pkgs, ... }: {

    home.packages = [ ];
    home.stateVersion = "23.11";
  };
}
