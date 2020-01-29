# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

module "oci_security_policies" {
  source           = "../../"
  
  default_compartment_id  = var.default_compartment_id
  vcn_id                  = oci_core_vcn.this.id
  
  standalone_nsg_rules  = {
    ingress_rules     = [
      {
        nsg_id        = oci_core_network_security_group.this.id
        description   = "this is a test!"
        stateless     = false
        protocol      = "6"
        src           = "10.1.2.3/32"
        src_type      = "CIDR_BLOCK"
        src_port      = {
          min         = "80"
          max         = "80"
        }
        dst_port      = {
          min         = "80"
          max         = "80"
        }
        icmp_code     = null
        icmp_type     = null
      }
    ]
    egress_rules        = [
      {
        nsg_id        = oci_core_network_security_group.this.id
        description   = "this is a test!"
        stateless     = true
        protocol      = "17"
        dst           = "10.1.2.3/32"
        dst_type      = "CIDR_BLOCK"
        src_port      = {
          min         = "123"
          max         = "123"
        }
        dst_port      = {
          min         = "53"
          max         = "53"
        }
        icmp_code     = null
        icmp_type     = null
      }
    ]
  }
}

resource "oci_core_vcn" "this" {
  dns_label             = null
  cidr_block            = "192.168.0.0/24"
  compartment_id        = var.default_compartment_id
  display_name          = "temp"
}

resource "oci_core_network_security_group" "this" {
    compartment_id      = var.default_compartment_id
    vcn_id              = oci_core_vcn.this.id
    display_name        = "temp"
}
