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
}