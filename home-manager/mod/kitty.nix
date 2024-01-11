{ pkgs, ... }: {
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
}
