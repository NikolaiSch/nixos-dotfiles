{ inputs, lib, config, pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lunarvim
    git
    kitty
    fzf
    swww
    waypaper
    vscode-fhs
    nixfmt
    wl-clipboard
  ];

}
