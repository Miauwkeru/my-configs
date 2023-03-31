source "qemu" "nixosimage" {
  boot_command = local.boot_command

  boot_wait         = "1m"
  boot_key_interval = "10ms"

  communicator      = "ssh"
  ssh_username      = "user"
  ssh_password      = "password"
  ssh_timeout       = "${var.ssh_timeout}"

  cpus              = 4
  memory            = 8192
  headless          = false

  iso_checksum      = "${var.iso_checksum}"
  iso_url           = "${var.iso_url}"
  output_directory  = "${local.vm_dir}"

  shutdown_command  = "echo 'password' | sudo -S shutdown -P now"

  vm_name           = "${var.vm_name}.qcow2"
  machine_type      = "ubuntu-q35"

  disk_size         = "${var.disk_size}"
  format            = "qcow2"
  disk_interface    = "virtio"

  http_content = {
    "/configuration.nix" = file("templates/configuration.nix")
  }
}

build {
  sources = ["source.qemu.nixosimage"]
}
