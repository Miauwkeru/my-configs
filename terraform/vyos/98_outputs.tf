output "provision_address" {
  value = libvirt_domain.vyos_router.network_interface[0].addresses[0]
}

output "network_interfaces" {
  value = [
    for i, obj in libvirt_domain.vyos_router.network_interface : {
      iface = "eth${i}",
      name  = obj.network_name
    }
  ]
}
