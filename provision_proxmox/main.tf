provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url = "${var.api_url}"
  pm_user = "${var.user}"
  pm_password = "${var.password}"
}

resource "proxmox_vm_qemu" "virtual_machine" {
  count = 1
  name = "my-new-test-${random_uuid.test.result}"
  desc = "terraform deployment"
  target_node = "${var.node}"

  clone = "${var.template}"
  cores = 2
  sockets = 1
  memory = 2560
  network {
    id = 0
    model = "virtio"
  }
  network {
    id = 1
    model = "virtio"
    bridge = "vmbr0"
  }
  disk {
    id = 0
    type = "virtio"
    storage = "local"
    size = "4G"
  }
  ssh_forward_ip = "10.0.0.1"
  ssh_user = "terraform"
  ssh_private_key = "${var.private_key}"

  os_type = "ubuntu"
  os_network_config = <<EOF
auto eth0
iface eno0 inet static
        address  10.0.2.99
        netmask  255.255.255.0
        gateway  10.0.2.2
EOF
}

resource "random_uuid" "test" {}
