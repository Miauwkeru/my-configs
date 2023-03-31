
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  

  # # Use the GRUB 2 boot loader in EFI mode.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/EFI"; # optional
    };
  };

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
    ];
    uid = 1000;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.qemuGuest.enable = true;
}