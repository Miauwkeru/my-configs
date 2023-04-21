resource "libvirt_domain" "vyos_router" {
  name        = var.vm_name
  description = "A routing virtual machine"

  vcpu   = 1
  memory = 512

  disk {
    volume_id = libvirt_volume.vyos_disk_image.id
  }

  network_interface {
    network_id     = libvirt_network.main_nat.id
    wait_for_lease = true
    mac            = "AA:BB:CC:11:22:22"
  }

}

resource "libvirt_volume" "vyos_disk_image" {
  name   = "vyos_disk.qcow"
  source = "${var.output_directory}/${var.vm_name}.qemu-vm/${var.vm_name}.qcow2"
  pool   = var.image_pool_name
}

resource "libvirt_network" "main_nat" {
  name      = "network_gate"
  mode      = "nat"
  addresses = ["10.200.42.0/24"]

  dhcp {
    enabled = true
  }

  autostart = true
}
