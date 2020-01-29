# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.




nsg_db                   = {
  nsg_db                 = {
    compartment_id    = null
    defined_tags      = null
    freeform_tags     = null
    ingress_rules     = [
      {
        description   = "this is a test!"
        stateless     = false
        protocol      = "6"
        src           = "nsg_app"
        src_type      = "NSG_NAME"
        src_port      = null
        dst_port      = {
          min         = "1521"
          max         = "1521"
        }
        icmp_code     = null
        icmp_type     = null
      }
    ]
    egress_rules        = [
      {
        description   = "this is another DB entry"
        stateless     = false
        protocol      = "17"
        dst           = "10.3.2.1/32"
        dst_type      = "CIDR_BLOCK"
        src_port      = null
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

nsg_app                 = {
  nsg_app               = {
    compartment_id      = null
    defined_tags        = null
    freeform_tags       = null
    ingress_rules       = [
      {
        stateless       = true
        protocol        = "6"
        description     = null
        src             = "10.0.0.0/24"
        src_type        = "CIDR_BLOCK"
        src_port        = null
        dst_port        = {
          min           = 443
          max           = 443
        }
        icmp_type       = null
        icmp_code       = null
      }
    ]
    egress_rules        = [
      {
        stateless       = true
        protocol        = "6"
        description     = null
        dst             = "10.0.0.0/24"
        dst_type        = "CIDR_BLOCK"
        src_port        = null
        dst_port        = {
          min           = 443
          max           = 443
        }
        icmp_type       = null
        icmp_code       = null
      },
      {
        stateless       = false
        protocol        = "6"
        description     = null
        dst             = "nsg_db"
        dst_type        = "NSG_NAME"
        src_port        = null
        dst_port        = {
          min           = 1521
          max           = 1521
        }
        icmp_type       = null
        icmp_code       = null
      },
      {
        stateless       = true
        protocol        = "6"
        description     = null
        dst             = "10.0.0.32/28"
        dst_type        = "CIDR_BLOCK"
        src_port        = {
          min           = 55000
          max           = 65535
        }
        dst_port        = {
          min           = 80
          max           = 80
        }
        icmp_type       = null
        icmp_code       = null
      }
    ]
  }
}
