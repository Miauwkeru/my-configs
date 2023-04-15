packer {
  required_plugins {
    sshkey = {
      version = " >= 1.0.1"
      source  = "github.com/ivoronin/sshkey"
    }
  }
}

data "sshkey" "install" {
  type = "ed25519"
  name = "id_${var.vm_name}"
}
