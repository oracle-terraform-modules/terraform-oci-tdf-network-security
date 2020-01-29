# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.




module "oci_security_policies" {
  source           = "../../"
  
  default_compartment_id  = var.default_compartment_id
  default_freeform_tags   = { "Department" = "Security" }
  vcn_id                  = oci_core_vcn.this.id
  
  security_lists = merge(
    var.vcn,
    var.web_test
  )
  nsgs = merge(
    var.nsg_db,
    var.nsg_app
  )
}

resource "oci_core_vcn" "this" {
  dns_label      = null
  cidr_block     = "192.168.0.0/24"
  compartment_id = var.default_compartment_id
  display_name   = "temp"
}