source "qemu" "nixos" {
  boot_command = local.boot_command
  accelerator  = "kvm"

  boot_wait         = "45s"
  boot_key_interval = "10ms"

  communicator         = "ssh"
  ssh_username         = var.user
  ssh_private_key_file = var.private_ssh_key
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
    inline = concat(
      [
        "mkdir -p ${local.home_manager_dir}"
      ],
      [
        for directory in local.all_dirs :
        "mkdir -p ${local.home_manager_dir}/${directory}"
      ]
    )

  }

  provisioner "file" {
    content     = templatefile("templates/home.nix.pkrtpl", 
      { user = var.user, includes = local.main_includes, nix_version = var.nix_version })
    destination = "${local.home_manager_dir}/home.nix"
  }

  provisioner "file" {
    sources     = [ for nix_file in local.nix_files: "${var.nix_home_path}/${nix_file}" ]
    destination = local.home_manager_dir
  }

  provisioner "shell" {
    inline = [
      "echo 'password' | sudo -S nix-channel --add https://github.com/nix-community/home-manager/archive/release-${var.nix_version}.tar.gz home-manager",
      "echo 'password' | sudo -S nix-channel --update",
      "echo 'password' | sudo -S nix-shell '<home-manager>' -A install",
      "nix-shell -p home-manager --run 'home-manager switch'",
    ]
  }

  post-processor "shell-local" {
    inline = ["mv ${local.vm_dir} ${var.vm_dir}"]
  }
}
