locals {
    boot_command = [
        "sudo su<enter><wait>",
        "stop sshd<enter>",
        "parted /dev/vda -- mklabel msdos<enter><wait>",
        "parted /dev/vda -- mkpart primary 1MiB -8GiB<enter><wait2>",
        "parted /dev/vda -- mkpart primary linux-swap -8GiB 100%<enter><wait2>",
        "mkfs.btrfs -f -L nixos /dev/vda1<enter><wait2>",
        "mkswap -L swap /dev/vda2<enter><wait2>",
        "mount -o discard,compress=lzo LABEL=nixos /mnt<enter><wait>",
        "swapon /dev/vda2<enter><wait>",
        "nixos-generate-config --root /mnt<enter><wait>",
        "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/configuration.nix > /mnt/etc/nixos/configuration.nix<enter><wait10s>",
        "sed -zi 's|fsType = \"btrfs\";|fsType = \"btrfs\";\n    options = [ \"discard\" \"compress=lzo\" ];|g' /mnt/etc/nixos/hardware-configuration.nix<enter><wait>",
        "nixos-install<enter>",
        "<wait1m>${var.root_pw}<enter><wait>${var.root_pw}<enter><wait>",
        "reboot<enter>"
    ]
    vm_dir   = "/dev/shm/${var.vm_name}.qemu-vm"
}