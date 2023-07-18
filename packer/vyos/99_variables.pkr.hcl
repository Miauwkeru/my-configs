variable "iso_url" {
    description = "The URL or path of the VyOS ISO to use"
    default = "../../isos/vyos-1.4-rolling-202209130217-amd64.iso"
    type = string
}

variable "iso_checksum" {
    description = "The checksum of the VyOS ISO to use"
    default = "sha256:3de97df16421508178ec5fdeede1e6e37ebce7ea5af5903970ef072dee0ade8a"
    type = string
}

variable "private_ssh_key" {
    description = "The private ssh key path"
    type        = string
}

variable "password" {
    description = "The initial password of the machine."
    type        = string
    default     = "vyos"
}

variable "vm_name" {
    description = "The name of the VM to be created"
    type = string
    default = "vyos-vm"
}

variable "vm_cpus" {
    description = "The number of CPUs for the VM"
    type = string
    default = "2"
}

variable "vm_dir" {
  description = "Path where the vm will get stored once creation is complete."
  type        = string
  default     = "~/vms"
}
