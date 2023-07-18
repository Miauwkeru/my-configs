variable "output_directory" {
  type    = string
  default = "~/vms"
}

variable "pool_path" {
  type = string
}

variable "local_cidr" {
  description = "cidr to block data to"
  type = string
  default = "192.168.2.0/24"
}

variable "networks" {
  description = "A list of networks to create"
  type        = list(string)
  default     = ["management"]
}
