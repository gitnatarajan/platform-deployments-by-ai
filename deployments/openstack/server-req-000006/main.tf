terraform {
  required_version = ">= 1.6.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = ">= 1.54.0"
    }
  }
  
}

provider "openstack" {}

resource "openstack_compute_instance_v2" "newtest" {
  name        = "newtest"
  image_name  = "cirros"
  flavor_name = "m1.tiny"

  network {
    name = "test"
  }
}
