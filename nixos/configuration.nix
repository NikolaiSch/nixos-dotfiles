# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    ./hardware-configuration.nix
    ./sys-pkgs.nix
    ./hardware-opts.nix
  ];
  security.sudo.wheelNeedsPassword = false;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  services = {
    xserver = {
      layout = "gb";
      xkbVariant = "";
      videoDrivers = [ "nvidia" ];
    };
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };
    getty.autologinUser = "vii";
  };

  nix = {
    registry = (lib.mapAttrs (_: flake: { inherit flake; }))
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    nixPath = [ "/etc/nix/path" ];
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      trusted-users = [ "root" "vii" ];

    };

  };

  nixpkgs = {
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
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;

  users.users = {
    vii = {
      hashedPassword = "";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO6lg2zpJwiGyquqRD+3bkGW1AqOOTsbZ+lLajxMmh/a nikolais@tuta.io"
      ];
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
    };
    yuri = {
      hashedPassword = "";
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
    };
  };
  programs.zsh.enable = true;

  system.stateVersion = "23.05";
}
