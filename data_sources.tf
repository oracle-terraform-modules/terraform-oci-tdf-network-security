# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.




data "oci_core_network_security_groups" "this" {
  compartment_id = var.default_compartment_id
  vcn_id = var.vcn_id
}
