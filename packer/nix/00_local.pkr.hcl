locals {
  pkg_dir = "home/${var.user}/.config/nixpkgs"

  boot_command = [
    "sudo su<enter><wait>",
    "parted /dev/vda -- mklabel msdos<enter><wait>",
    "parted /dev/vda -- mkpart primary 1MiB -8GiB<enter><wait2>",
    "parted /dev/vda -- mkpart primary linux-swap -8GiB 100%<enter><wait2>",
    "mkfs.btrfs -f -L nixos /dev/vda1<enter><wait2>",
    "mkswap -L swap /dev/vda2<enter><wait2>",
    "mount -o discard,compress=lzo LABEL=nixos /mnt<enter><wait>",
    "swapon /dev/vda2<enter><wait>",
    "nixos-generate-config --root /mnt<enter><wait>",
    "nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager<enter><wait>",
    "nix-channel --update<enter><wait10s>",
    "mkdir -p /mnt/${local.pkg_dir}<enter><wait>",
    "echo '{ allowUnfree = true; }' > /mnt/${local.pkg_dir}/config.nix<enter><wait>",
    "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/home.nix > /mnt/${local.pkg_dir}/home.nix<enter><wait>",
    "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/code.nix > /mnt/${local.pkg_dir}/code.nix<enter><wait>",
    "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/configuration.nix > /mnt/etc/nixos/configuration.nix<enter><wait>",
    "sed -zi 's|fsType = \"btrfs\";|fsType = \"btrfs\";\n    options = [ \"discard\" \"compress=lzo\" ];|g' /mnt/etc/nixos/hardware-configuration.nix<enter><wait>",
    "nixos-install<enter>",
    "<wait2m>${var.root_pw}<enter><wait>${var.root_pw}<enter><wait>",
    "chown -R 1000:users /mnt/home/${var.user}/.config<enter><wait>",
    "reboot<enter>"
  ]
  vm_dir = "/dev/shm/${var.vm_name}.qemu-vm"
}
