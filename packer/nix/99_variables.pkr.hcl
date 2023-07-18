variable "disk_size" {
  type    = string
  default = "102400M"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:eaff593c1e9acc22ed87ae39d480df80a4ec6c3ee06f2f889250193d8e4f1cca"
}

variable "iso_url" {
  type    = string
  default = "https://channels.nixos.org/nixos-23.05/latest-nixos-minimal-x86_64-linux.iso"
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
  description = "Path to a nix file directory."
  default     = null
}

variable "vm_dir" {
  type        = string
  description = "Path where the vm will get stored once creation is complete."
  default     = "~/vms"
}

variable "nix_version" {
  type        = string
  description = "The version of nixos to install."
  default     = "23.05"
}

variable "private_ssh_key" {
  type        = string
  description = "A private ssh key used to communicate with the instance."
}
