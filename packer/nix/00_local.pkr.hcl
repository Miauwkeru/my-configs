locals {
    boot_command = [
        "sudo su<enter><wait>",
        "stop sshd<enter>",
        "parted /dev/vda -- mklabel gpt<enter><wait>",
        "parted /dev/vda -- mkpart ESP fat32 1MiB 512MiB<enter><wait2>",
        "parted /dev/vda -- mkpart primary 512MiB -8GiB<enter><wait2>",
        "parted /dev/vda -- mkpart primary linux-swap -8GiB 100%<enter><wait2>",
        "parted /dev/vda -- set 1 boot on<enter><wait>",
        "mkfs.fat -F 32 -n boot /dev/vda1<enter><wait2>",
        "mkfs.btrfs -f -L nixos /dev/vda2<enter><wait2>",
        "mkswap -L swap /dev/vda3<enter><wait2>",
        "mount -o discard,compress=lzo LABEL=nixos /mnt<enter><wait>",
        "mkdir -p /mnt/boot; mount LABEL=boot /mnt/boot<enter><wait>",
        "swapon /dev/vda3<enter><wait>",
        "nixos-generate-config --root /mnt<enter><wait>",
        "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/configuration.nix > /mnt/etc/nixos/configuration.nix<enter><wait>",
        "nixos-install<enter>",
        "<wait1m>${var.root_pw}<enter><wait>${var.root_pw}<enter><wait>",
        "reboot<enter>"
    ]
    vm_dir   = "/tmp/${var.vm_name}.qemu-vm"
}