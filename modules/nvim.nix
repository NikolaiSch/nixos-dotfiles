{ config, pkgs, ... }: {
  imports = [ <home-manager/nixos> ];
  home-manager.users.vii = { pkgs, ... }: {
    programs.neovim = { enable = true; };
  };

}
