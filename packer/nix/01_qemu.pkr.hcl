source "qemu" "nixos" {
  boot_command = local.boot_command
  accelerator  = "kvm"

  boot_wait         = "45s"
  boot_key_interval = "10ms"

  communicator         = "ssh"
  ssh_username         = var.user
  ssh_private_key_file = data.sshkey.install.private_key_path
  ssh_timeout          = "${var.ssh_timeout}"

  cpus     = 4
  memory   = 8192
  headless = false

  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  output_directory = local.vm_dir

  shutdown_command = "echo 'password' | sudo -S shutdown -P now"

  vm_name      = "${var.vm_name}.qcow2"
  machine_type = "q35"

  disk_size      = "${var.disk_size}"
  format         = "qcow2"
  disk_interface = "virtio"

  http_content = local.http_content
}

build {
  sources = ["source.qemu.nixos"]

  provisioner "shell" {
    inline = [
      "echo 'password' | sudo -S nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager",
      "echo 'password' | sudo -S nix-channel --update",
      "echo 'password' | sudo -S nix-shell '<home-manager>' -A install",
      "nix-shell -p home-manager --run 'home-manager switch'",
    ]
  }

  post-processor "shell-local" {
    inline = ["mv ${source.output_directory} ${var.vm_dir}"]
  }
}
