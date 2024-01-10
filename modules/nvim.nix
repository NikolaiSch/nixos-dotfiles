{ config, pkgs, ... }: {
  imports = [ <home-manager/nixos> ];
  home-manager.users.vii = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [ nord-nvim ];
    };
  };

}
