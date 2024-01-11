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
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    lunarvim
    git

  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

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

  programs.eza = {
    enable = true;
    enableAliases = true;
    extraOptions = [ "--group-directories-first" ];
  };

  programs.chromium.enable = true;
  programs.waybar = { enable = true; };

  home.file = {
    ".config/waybar" = { source = /home/vii/nixc/home-manager/configs/waybar; };
  };

  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;

    settings = {
      "$mod" = "SUPER";
      "$term" = "kitty";
      "$nx" = "kitty -d '~/nixc/' zsh -c 'nxf'";
      "$editor" = "code";
      monitor = [ "eDP-1,1920x1080@60, 0x0,1" ];
      exec-once = "waybar";
      bind = [
        "$mod, Return, exec, $term"
        "$mod SHIFT, N, exec, $nx"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod SHIFT, F, exec, thunar"
        "$mod SHIFT, B, exec, chromium"
        "$mod SHIFT, E, exec, code"
        # "$mod SHIFT, P,"
        "$mod, V, togglefloating"
        #"$mod, R"
        "$mod, Z, togglesplit"

        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"

      ] ++ (builtins.concatLists (builtins.genList (x:
        let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
        in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
          "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        ]) 10));
      input = {
        kb_layout = "gb";
        follow_mouse = 1;
        touchpad = { natural_scroll = "yes"; };
      };
      general = {
        gaps_in = 10;
        gaps_out = 20;
        border_size = 3;

        "col.active_border" = "rgba(5e81acee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "master";
        allow_tearing = false;
      };
      decoration = {
        rounding = 3;
        inactive_opacity = 0.6;

        blur = {
          enabled = true;
          size = 4;
          passes = 3;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 7, default"
          "fade, 1, 7, default"
          "workspaces, 1, 7, default"
        ];
      };

      master = { new_is_master = true; };

      gestures = {
        workspace_swipe = "on";
        workspace_swipe_fingers = 3;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      windowrulev2 = "nomaximizerequest, class:.*";
    };
  };

  programs.kitty = {
    enable = true;
    font.package = pkgs.fira-code-nerdfont;
    font.name = "FiraCode NerdFont";
    settings = {
      cursor_shape = "beam";
      background_opacity = "0.5";
      background_tint = "0.1";
      foreground = "#D8DEE9";
      background = "#2E3440";
      selection_foreground = "#000000";
      selection_color = "#FFFACD";
      url_color = "#0087BD";
      cursor = "#81A1C1";

      color0 = "#3B4252";
      color8 = "#4C566A";

      color1 = "#BF616A";
      color9 = "#BF616A";

      color2 = "#A3BE8C";
      color10 = "#A3BE8C";

      color3 = "#EBCB8B";
      color11 = "#EBCB8B";

      color4 = "#81A1C1";
      color12 = "#81A1C1";

      color5 = "#B48EAD";
      color13 = "#B48EAD";

      color6 = "#88C0D0";
      color14 = "#8FBCBB";

      color7 = "#E5E9F0";
      color15 = "#ECEFF4";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
