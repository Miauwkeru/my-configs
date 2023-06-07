variable "vm_name" {
  type    = string
  default = "vyos-vm"
}

variable "output_directory" {
  type = string
}

variable "image_pool_name" {
  type = string
}

variable "network_interfaces" {
  description = "Network interfaces to attach to the vyos image."
  type = list(object({
    name = string
    id = string
  }))
}
