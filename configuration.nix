# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./home.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix = {
    settings = {
      extra-experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      modesetting.enable = true;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:10:0:0";
        sync.enable = true;
      };
    };
  };

  networking = {
    hostName = "vixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/London";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      pkgs.nixfmt
      pkgs.wl-clipboard
      pkgs.brave
      pkgs.lunarvim
      pkgs.zsh
    ];
    variables = {
      EDITOR = "lvim";
      VISUAL = "lvim";
    };
  };
  security.polkit.enable = true;
  programs.zsh.enable = true;

  services = {
    xserver = {
      layout = "gb";
      xkbVariant = "";
      videoDrivers = [ "nvidia" ];
    };
    openssh.enable = true;
    getty.autologinUser = "vii";
  };

  console = { keyMap = "uk"; };

  users.users.vii = {
    isNormalUser = true;
    description = "vii";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ pkgs.udev-gothic-nf ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";
}
