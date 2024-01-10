{ config, pkgs, ... }: {
  imports = [ <home-manager/nixos> ];
  home-manager.users.vii = { pkgs, ... }: {
    programs = { 
      fzf.enable = true;    
      zsh = {
	enable = true;
	enableAutosuggestions = true;
	oh-my-zsh = {
	  enable = true;
	  plugins = [ "colored-man-pages" "fzf" "git" "sudo" ];
	  theme = "agnoster";
	};
	autocd = true;
	defaultKeymap = "viins";
	shellAliases = {
	  nx = "cd /etc/nixos";
	  nxm = "cd /etc/nixos/modules";

	  nxc = "nx; sudo nvim configuration.nix";
	  nxh = "nx; sudo nvim home-manager.nix";

	  nr = "sudo nixos-rebuild build";
	  nrs = "sudo nixos-rebuild switch";

	  nfmt = "sudo nixfmt /etc/nixos/**";
	  nxf = "nx; sudo nvim $(fzf)";
	};
      };
    };
    services.clipman.enable = true;
  };

}
