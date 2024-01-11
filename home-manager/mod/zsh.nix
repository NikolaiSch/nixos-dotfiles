{ ... }: {
programs.zsh = {
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
      nxc = "sudo lvim ~/nixc/nixos/configuration.nix"; # Nixos configuration
      nxh = "sudo lvim ~/nixc/home-manager/home.nix"; # Nixos Home
      nx = "cd ~/nixc/"; # Nixos location

      nr =
        "sudo nixos-rebuild switch --flake ~/nixc#nixos"; # Nixos Rebuild Switch
      nh =
        "home-manager switch --flake ~/nixc#vii@nixos"; # Nixos Rebuild Switch

      nfmt = "sudo nixfmt ~/nixc/**"; # Nix Format
      nxf = "nx; sudo lvim $(fzf -1)"; # NixOs Find
    };
  };

}
