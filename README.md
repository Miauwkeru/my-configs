# Packer-vm-config

A repository containing configuration files for:

- Packer vms (qemu builder)
- Nix configuration:


## Nix configuration

Template files:
`home.nix`: A base for home-manager configuration files.
`configuration.nix`: A base hardware configuration file, containing some default packages.


Home-manager configuration:
`program-config`: Contains folders that can be added to the home.nix packer templates.
These folders require a `default.nix` inside of them, otherwise when you create the `nixos` virtual machine it will error on provisioning.

## Requirements

- qemu
- hashicorp packer

## Experimental stuff

### packer
Some additional configuration files for creating routing instances.

- `vyos`: To create a base vyos virtual machine
  `ansible`: Used to provision the vyos instance afterwards. 

- `opensense`: To create a base opnsense virtual machine.

`terraform`:

Configuration files that provision a `vyos` instance when adding a new network interface to it.

## How to use

The `setup.sh` file can be used to create a specific instance, currently it is hardcoded to create the nixos configuration using qemu.
Run the following command to run it, where it uses the `program-config` directory as a base for the home-manager configuration.

> bash setup.sh

