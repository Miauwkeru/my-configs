locals {
  pkg_dir = "home/${var.user}/.config/nixpkgs"
  home_manager_dir = "home/${var.user}/.config/home-manager"

  nix_files     = var.nix_home_path != null ? fileset(var.nix_home_path, "**") : []
  all_dirs      = setunion([for file in local.nix_files : dirname(file)])
  main_includes = setunion([for test in local.all_dirs : split("/", test)[0]])


  boot_command = concat(
    [
      "sudo su<enter><wait>",
      "parted /dev/vda -- mklabel msdos<enter><wait>",
      "parted /dev/vda -- mkpart primary 1MiB -8GiB<enter><wait2>",
      "parted /dev/vda -- mkpart primary linux-swap -8GiB 100%<enter><wait2>",
      "mkfs.btrfs -f -L nixos /dev/vda1<enter><wait2>",
      "mkswap -L swap /dev/vda2<enter><wait2>",
      "mount -o discard,compress=lzo LABEL=nixos /mnt<enter><wait>",
      "swapon /dev/vda2<enter><wait>",
      "nixos-generate-config --root /mnt<enter><wait>",
      "nix-channel --add https://github.com/nix-community/home-manager/archive/release-${var.nix_version}.tar.gz home-manager<enter><wait>",
      "nix-channel --update<enter><wait10s>",
      "mkdir -p /mnt/${local.pkg_dir}<enter><wait>",
      "mkdir -p /mnt/${local.home_manager_dir}",
      "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/configuration.nix > /mnt/etc/nixos/configuration.nix<enter><wait>",
      "echo '{ allowUnfree = true; }' > /mnt/${local.pkg_dir}/config.nix<enter><wait>",
      "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/home.nix > /mnt/${local.pkg_dir}/home.nix<enter><wait>",
      "sed -zi 's|fsType = \"btrfs\";|fsType = \"btrfs\";\n    options = [ \"discard\" \"compress=lzo\" ];|g' /mnt/etc/nixos/hardware-configuration.nix<enter><wait>",
    ],
    [
      for directory in local.all_dirs :
      "mkdir -p /mnt/${local.home_manager_dir}/${directory}<enter><wait>"
    ],
    [
      for x in local.nix_files :
      "curl http://{{ .HTTPIP }}:{{ .HTTPPort }}/home_manager_data/${x} > /mnt/${local.home_manager_dir}/${x}<enter><wait>"
    ],
    [
      "nixos-install<enter>",
      "<wait2m>${var.root_pw}<enter><wait>${var.root_pw}<enter><wait>",
      "chown -R 1000:users /mnt/home/${var.user}/.config<enter><wait>",
      "reboot<enter>"
    ]
  )

  vm_dir = "/dev/shm/${var.vm_name}.qemu-vm"

  http_content = merge(
    { for x in local.nix_files : "/home_manager_data/${x}" => file("${var.nix_home_path}/${x}") },
    {
      "/configuration.nix" = templatefile("templates/configuration.nix.pkrtpl", {
        user       = var.user,
        public_key = file("${var.private_ssh_key}.pub"),
        nix_version = var.nix_version
      }),
      "/home.nix" = templatefile("templates/home.nix.pkrtpl", { user = var.user, includes = local.main_includes, nix_version = var.nix_version }),
    }
  )
}
