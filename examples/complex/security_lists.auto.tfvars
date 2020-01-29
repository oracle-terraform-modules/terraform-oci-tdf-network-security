# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


/*
Challenge: TF doesn't allow for dynamically accessing map keys - so it's not possible to do the following:

sls = {}
sls[vcn] = {
  ...
}
sls[web_test] = {
  ...
}

The following code sets the variable name (which happens to be the same as the name of the Security List) to a map, where the key is the display_name of the Security List.  It looks kind of funky at first glance, but works nicely for allowing for discrete variables per SL, as well as supporting a handy merge(var1, var2, var3, var4, ...) when setting the security_list attribute.
*/

vcn                     = {
  vcn                   = {
    compartment_id      = null
    defined_tags        = null
    freeform_tags       = null
    ingress_rules       = null
    egress_rules        = [
      {
        stateless       = true
        protocol        = "6"
        dst             = "10.0.0.0/24"
        dst_type        = "CIDR_BLOCK"
        src_port        = {
          min           = 22
          max           = 22
        }
        dst_port        = null
        icmp_type       = null
        icmp_code       = null
      },
      {
        stateless       = true
        protocol        = "6"
        dst             = "10.0.0.16/28"
        dst_type        = "CIDR_BLOCK"
        src_port        = null
        dst_port        = {
          min           = 80
          max           = 80
        }
        icmp_type       = null
        icmp_code       = null
      },
      {
        stateless       = true
        protocol        = "6"
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

web_test                = {
  web_test              = {
    compartment_id      = null
    defined_tags        = null
    freeform_tags       = null
    ingress_rules       = null
    egress_rules        = [
      {
        stateless       = true
        protocol        = "6"
        dst             = "10.0.0.0/24"
        dst_type        = "CIDR_BLOCK"
        src_port        = {
          min           = 22
          max           = 22
        }
        dst_port        = null
        icmp_type       = null
        icmp_code       = null
      },
      {
        stateless       = true
        protocol        = "6"
        dst             = "10.0.0.16/28"
        dst_type        = "CIDR_BLOCK"
        src_port        = null
        dst_port        = {
          min           = 80
          max           = 80
        }
        icmp_type       = null
        icmp_code       = null
      },
      {
        stateless       = true
        protocol        = "6"
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
