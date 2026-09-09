terraform {
  required_version = ">= 1.6.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = ">= 1.54.0"
    }
  }
  
}

provider "openstack" {
  # MicroStack commonly uses a self-signed Keystone certificate.
  # Keep this explicit for Terraform; the Python SDK verify_ssl setting does
  # not automatically apply to the Terraform provider.
  insecure = true
}

resource "openstack_compute_instance_v2" "demo11" {
  name        = "demo11"
  image_name  = "cirros"
  flavor_name = "m1.tiny"

  network {
    name = "test"
  }
}
