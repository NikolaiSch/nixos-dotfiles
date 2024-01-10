{ config, pkgs, ... }: {
  imports = [ <home-manager/nixos> ];
  home-manager.users.vii = { pkgs, ... }: {
    programs.git = {
      enable = true;
      userName = "nikolai";
      userEmail = "nikolais@tuta.io";
      extraConfig = {
	safe.directory = [ "/etc/nixos" ];
      };
    };
  };

}
