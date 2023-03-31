
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";


  # Install minimal packages needed for provisioning
  environment.systemPackages = with pkgs; [
    git
  ];

  # Turn off mutable users so `nixos-install` does not prompt to set a password
  users.mutableUsers = false;

  # Create my personal user
  # The password should be changed later
  users.extraUsers.user = {
    description = "user";
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [
      "wheel"
      "docker"
    ];
    uid = 1000;
  };

  services = {
    openssh.enable = true;
    qemuGuest.enable = true;
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
      displayManager.defaultSession = "xfce";
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
    };
  };

  # Set docker 
  virtualisation.docker = {
    enable = true;
    # Allow docker to use btrfs
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}