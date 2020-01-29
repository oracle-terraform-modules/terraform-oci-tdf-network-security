# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


module "oci_security_policies" {
  source           = "../../"
  default_compartment_id  = var.default_compartment_id
  vcn_id                  = oci_core_vcn.this.id
  
  security_lists = {
    vcn = {
      compartment_id    = null
      defined_tags      = null
      freeform_tags     = null
      ingress_rules     = null
      egress_rules      = [
        {
          stateless     = true
          protocol      = "6"
          dst           = "10.0.0.0/24"
          dst_type      = "CIDR_BLOCK"
          src_port      = {
            min         = 22
            max         = 22
          }
          dst_port      = null
          icmp_type     = null
          icmp_code     = null
        },
        {
          stateless     = true
          protocol      = "6"
          dst           = "10.0.0.16/28"
          dst_type      = "CIDR_BLOCK"
          src_port      = null
          dst_port      = {
            min         = 80
            max         = 80
          }
          icmp_type     = null
          icmp_code     = null
        },
        {
          stateless     = true
          protocol      = "6"
          dst           = "10.0.0.32/28"
          dst_type      = "CIDR_BLOCK"
          src_port      = {
            min         = 55000
            max         = 65535
          }
          dst_port      = {
            min         = 80
            max         = 80
          }
          icmp_type     = null
          icmp_code     = null
        }
      ]
    },
    web_test            = {
      compartment_id    = null
      defined_tags      = null
      freeform_tags     = null
      ingress_rules     = null
      egress_rules      = [
        {
          stateless     = true
          protocol      = "6"
          dst           = "10.0.0.0/24"
          dst_type      = "CIDR_BLOCK"
          src_port      = {
            min         = 22
            max         = 22
          }
          dst_port      = null
          icmp_type     = null
          icmp_code     = null
        },
        {
          stateless     = true
          protocol      = "6"
          dst           = "10.0.0.16/28"
          dst_type      = "CIDR_BLOCK"
          src_port      = null
          dst_port      = {
            min         = 80
            max         = 80
          }
          icmp_type     = null
          icmp_code     = null
        },
        {
          stateless     = true
          protocol      = "6"
          dst           = "10.0.0.32/28"
          dst_type      = "CIDR_BLOCK"
          src_port      = {
            min         = 55000
            max         = 65535
          }
          dst_port      = {
            min         = 80
            max         = 80
          }
          icmp_type     = null
          icmp_code     = null
        }
      ]
    }
  }

  nsgs                  = {
    db                  = {
      compartment_id    = null
      defined_tags      = null
      freeform_tags     = null
      ingress_rules     = [
        {
          description   = "this is a test!"
          stateless     = false
          protocol      = "6"
          src           = "10.1.2.3/32"
          src_type      = "CIDR_BLOCK"
          src_port      = {
            min = "80"
            max = "80"
          }
          dst_port      = {
            min = "80"
            max = "80"
          }
          icmp_code     = null
          icmp_type     = null
        }
      ]
      egress_rules        = [
        {
          description   = "this is a test!"
          stateless     = true
          protocol      = "17"
          dst           = "10.1.2.3/32"
          dst_type      = "CIDR_BLOCK"
          src_port      = {
            min = "123"
            max = "123"
          }
          dst_port      = {
            min = "53"
            max = "53"
          }
          icmp_code     = null
          icmp_type     = null
        }
      ]
    }
  }
}

resource "oci_core_vcn" "this" {
  dns_label             = null
  cidr_block            = "192.168.0.0/24"
  compartment_id        = var.default_compartment_id
  display_name          = "temp"
}
