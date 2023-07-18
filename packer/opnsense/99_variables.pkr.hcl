variable "disk_size" {
  type    = string
  default = "4096M"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:95962ad9c64ec9bd19d3b91caac0ab1e458d93f2003185a5ae56903a00a6669b"
}

variable "iso_url" {
  type    = string
  default = "../../isos/OPNsense-23.1-OpenSSL-dvd-amd64.iso"
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
  default = "opnsense"
}

variable "vm_dir" {
  description = "Path where the vm will get stored once creation is complete."
  type        = string
  default     = "~/vms"
}
