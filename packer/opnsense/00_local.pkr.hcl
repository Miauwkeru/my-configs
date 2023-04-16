locals {

  ssh_options = join("\n", [
    "<enabled>enabled</enabled>",
    "<permitrootlogin>1</permitrootlogin>",
    "<passwordauth>1</passwordauth>"
  ])

  boot_command = [
    "<wait10>",
    "installer<enter><wait>",
    "opnsense<enter><wait>",
    "<enter><wait>",
    "<enter><wait>",
    "<enter><wait>",
    "<left><wait>",
    "<enter><wait>",
    "<wait1m><enter><wait>",
    "opnsense<enter><wait>",
    "opnsense<enter><wait20s>",
    "<down><enter><wait45s>",
    "root<enter><wait>",
    "opnsense<enter><wait>",
    "8<enter><wait>",
    "dhclient vtnet0<enter><wait>",
    "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/config.xml > /conf/config.xml<enter><wait>",
    "reboot<enter><wait45>",
    "root<enter><wait>",
    "opnsense<enter><wait>",
    "8<enter><wait>",
    "dhclient vtnet0<enter><wait>",
  ]

  vm_dir = "/dev/shm/${var.vm_name}.qemu-vm"

}
