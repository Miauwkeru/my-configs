resource "libvirt_pool" "image_pool" {
  name = "vm_images"
  type = "dir"
  path = var.pool_path
}

module "router-instance" {
  source = "./vyos"

  output_directory = var.output_directory
  image_pool_name  = libvirt_pool.image_pool.name
  # Attach network interfaces to the router instance
  network_interfaces = [for s in libvirt_network.networks: {
    name = s.name
    id   = s.id
  }]
}

resource "null_resource" "export_network_info" {
  depends_on = [module.router-instance]

  provisioner "local-exec" {
    command = "echo '${jsonencode(module.router-instance.network_interfaces)}' > vyos_interfaces.json"
  }

  provisioner "local-exec" {
    command = <<EOF
        ansible-playbook -i '${module.router-instance.provision_address},' \
        -e 'json_location=${path.cwd}/vyos_interfaces.json' \
        -e 'ansible_connection=ansible.netcommon.network_cli' \
        -e 'ansible_user=vyos' \
        -e 'internal_address=${var.local_cidr}' \
        --private-key '${path.cwd}/../keys/vyos-ed25519' \
        -e 'ansible_network_os=vyos.vyos.vyos' \
        ${path.cwd}/../ansible/configure_network.yml
    EOF
  }
}

resource "libvirt_network" "networks" {
  for_each  = toset(var.networks)
  name   = each.key
  
  autostart = true
}
