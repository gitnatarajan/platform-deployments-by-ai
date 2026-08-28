terraform {
  required_version = ">= 1.6.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = ">= 1.54.0"
    }
  }
}

# Credentials are read from OS_* environment variables on the Terraform node.
# insecure=true is equivalent to `openstack --insecure` and avoids the
# MicroStack CA parsing problem seen with OS_CACERT.
provider "openstack" {
  insecure = true
}

resource "openstack_compute_instance_v2" "vm" {
  name        = "cirros"
  image_name  = "cirros"
  flavor_name = "m1.tiny"

  network {
    name = "test"
  }
}

output "vm_details" {
  description = "OpenStack VM details captured by Terraform state"
  value = {
    id           = openstack_compute_instance_v2.vm.id
    name         = openstack_compute_instance_v2.vm.name
    access_ip_v4 = openstack_compute_instance_v2.vm.access_ip_v4
    access_ip_v6 = openstack_compute_instance_v2.vm.access_ip_v6
    image        = openstack_compute_instance_v2.vm.image_name
    flavor       = openstack_compute_instance_v2.vm.flavor_name
    network      = openstack_compute_instance_v2.vm.network
  }
}
