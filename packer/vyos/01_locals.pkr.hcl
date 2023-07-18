locals {
  split_key = split(" ", file("${var.private_ssh_key}.pub"))
  boot_command = [
  # bootloader
    "<enter><wait40>",
  # Install vyos
    "vyos<enter><wait>",
    "vyos<enter><wait>",
    "install image<enter><wait>",
    "<enter><wait>",
    "<enter><wait>",
    "<enter><wait>",
    "Yes<enter><wait>",
    "<enter><wait10>",
    "<enter><wait10>",
    "<enter><wait>",
    "${var.password}<enter><wait10>",
    "${var.password}<enter><wait10>",
    "<enter><wait40>",
    "reboot<enter><wait>",
    "Yes<enter><wait60>",
  # after reboot
    "vyos<enter><wait>",
    "${var.password}<enter><wait>",
    "rm /config/config.boot*<enter><wait>",
    "configure<enter><wait>",
    "set interfaces ethernet eth0 address dhcp<enter><wait>",
    "set service ssh<enter><wait>",
    "set service ssh disable-host-validation<enter><wait>",
    "set service ssh disable-password-authentication<enter><wait>",
  # Configure ssh key for vyos
    "set system login user vyos authentication public-keys ${local.split_key[2]} type ${local.split_key[0]}<enter><wait>",
    "set system login user vyos authentication public-keys ${local.split_key[2]} key ${local.split_key[1]}<enter><wait>",
    "commit<enter><wait>",
    "save<enter><wait>",
    "delete interface ethernet eth0 hw-id<enter><wait5>",
    "commit<enter><wait5>",
    "save<enter><wait5>",
    "exit<enter><wait>",
  ]
  vm_dir = "/dev/shm/${var.vm_name}.qemu-vm"
}
