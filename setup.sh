#!/bin/bash

OUTPUT_DIR=~/vms
BUILDER_TYPE=qemu
BASE_DIR=$PWD
KEY_DIR="${BASE_DIR}/.keys"

create_ssh_key() {
	local name=$1
	local type=${2:-"-t rsa -b 4096"}

	mkdir -p ${KEY_DIR}
	if [[ ! -f "${KEY_DIR}/${name}" ]]; then
		ssh-keygen -f "${KEY_DIR}/${name}" $type -q -N ""
	fi

}

build_image() {
	local directory=$1
	local image=$(basename $1)
	shift
	local additional_vars="$@"
	local output=${OUTPUT_DIR}/${image}*/${image}*.qcow2

	if [[ $output != *"*"* ]]; then
		echo "$image already created."
		return
	fi

	pushd ${directory}
	create_ssh_key "${image}-ed25519" "-t ed25519"
	packer build -var private_ssh_key="${KEY_DIR}/${image}-ed25519" $additional_vars .
	popd
}

orchestrate() {
	local tf_command=$1
	pushd terraform
	terraform ${tf_command} -var pool_path="$HOME/VMs" -var output_directory="${OUTPUT_DIR}"
	popd
}

build_image packer/nix -var nix_home_path=$PWD/program-config
#orchestrate "apply"
