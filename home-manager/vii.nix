# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    inputs.ags.homeManagerModules.default
    # You can also split up your configuration and import pieces of it here:
    # ./lvim.nix
    # ./hyprland.nix

    ./mod/zsh.nix
    ./mod/hyprland.nix
    ./mod/kitty.nix
  ];

  programs.ags = {
    enable = true;

    configDir = /home/vii/nixc/home-manager/configs/ags;

    extraPackages = [ ];
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "vii";
    homeDirectory = "/home/vii";
    packages = with pkgs; [ lunarvim git ];
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  programs.chromium.enable = true;
  programs.waybar = { enable = true; };

  home.file = {
    ".config/waybar" = { source = /home/vii/nixc/home-manager/configs/waybar; };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
