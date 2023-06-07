output "provision_address" {
  value = flatten([
    for obj in libvirt_domain.vyos_router.network_interface : obj.addresses[*] if obj.network_id == libvirt_network.main_nat.id
  ])[0]
}

output "network_interfaces" {
  value = [
    for i, obj in libvirt_domain.vyos_router.network_interface : {
      iface = "eth${i}",
      name  = obj.network_name
    }
  ]
}
