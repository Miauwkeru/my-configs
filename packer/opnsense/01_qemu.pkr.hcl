source "qemu" "base" {
  boot_command = local.boot_command
  accelerator  = "kvm"

  boot_wait         = "45s"
  boot_key_interval = "10ms"

  communicator = "ssh"
  ssh_username = "root"
  ssh_password = "opnsense"
  ssh_timeout  = var.ssh_timeout

  cpus     = 4
  memory   = 8192
  headless = false

  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  output_directory = local.vm_dir

  shutdown_command = "shutdown -p now"

  vm_name      = "${var.vm_name}.qcow2"
  machine_type = "q35"

  disk_size      = "${var.disk_size}"
  format         = "qcow2"
  disk_interface = "virtio"

  http_content = {
    "/config.xml" = file("templates/default.xml")
  }

}

build {
  sources = ["source.qemu.base"]

  post-processor "shell-local" {
    inline = ["mv ${local.vm_dir} ${var.vm_dir}"]
  }
}
