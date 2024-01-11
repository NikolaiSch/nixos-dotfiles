{ pkgs, ... }: {
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

}