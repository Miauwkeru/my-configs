variable "disk_size" {
  type    = string
  default = "102400M"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:54d1f06fd8042ecc2f691d09a0231a62f4d4c7c3816d8c9602ad9e2c14b72970"
}

variable "iso_url" {
  type    = string
  default = "https://channels.nixos.org/nixos-22.11/latest-nixos-minimal-x86_64-linux.iso"
}

variable "restart_timeout" {
  type    = string
  default = "5m"
}

variable "ssh_timeout" {
  type    = string
  default = "6h"
}

variable "vm_name" {
  type    = string
  default = "nixos-vm"
}

variable "root_pw" {
  type    = string
  default = "5up3r53cr3tPw"
}

variable "user" {
  type    = string
  default = "user"
}

variable "nix_home_path" {
  type        = string
  description = "Path to a nix file direction."
}
