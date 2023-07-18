source "qemu" "vyos" {
  iso_url      = var.iso_url
  iso_checksum = var.iso_checksum
  vm_name      = "${var.vm_name}.qcow2"

  accelerator = "kvm"

  cpus      = 1
  memory    = 512
  disk_size = "4096M"
  format    = "qcow2"

  ssh_username         = "vyos"
  ssh_private_key_file = var.private_ssh_key

  boot_wait         = "5s"
  boot_command      = local.boot_command
  boot_key_interval = "25ms"

  output_directory = local.vm_dir
}


build {
  sources = ["source.qemu.vyos"]

  post-processor "shell-local" {
    inline = ["mv ${local.vm_dir} ${var.vm_dir}"]
  }

}
