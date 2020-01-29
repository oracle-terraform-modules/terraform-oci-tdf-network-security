# Oracle Cloud Infrastructure (OCI) Network Security Module for Terraform

## Introduction

This module gives an interface to managing security policies in OCI using the following resources:

* Security Lists.

## Solution

This serves as a foundational component in an OCI environment, providing the ability to configure network security policies within OCI.

This module provides the ability to create and manage the following:

| Resource | Created by Default? |
|---|---|
| Security List(s) | No |
| Network Security Group(s) | No |
| Network Security Group Rule(s) | No |


### Prerequisites
This module does not create any dependencies or prerequisites (these must be created prior to using this module):

* VCN

## Getting Started

This is a core service module that is foundational to many other resources in OCI, so there is really nothing to directly access.

Several fully-functional examples have been provided in the `examples` directory.  For a quick-start guide, at minimum, you need the following (for the most basic deployment):

```
module "oci_security_policies" {
  ...<SNIP - for brevity>...
    
  default_compartment_id  = var.default_compartment_id
  vcn_id                  = oci_core_vcn.this.id
  
  security_lists = {}
  nsgs = {}
}
```

The above example won't actually deploy any subnets (because the *security_lists* and *nsgs* attributes are an empty map), however if you populate this map with entries (keys = name, values = subnet attributes), Security Lists and/or NSGs would be deployed.

## Accessing the Solution
This core service module is typically used at deployment, with no further access required.


## Module inputs


| Attribute | Data Type | Required | Default Value | Valid Values | Description |
|---|---|---|---|---|---|
| default\_compartment\_id | string | yes | none | string of the compartment OCID | This is the default OCID that will be used when creating objects (unless overridden for any specific object).  This needs to be the OCID of a pre-existing compartment (it will not create the compartment. |
| vcn\_id | string | yes | N/A (no default) | The OCID of the VCN where the Security List(s) should be created. |
| default\_defined\_tags | map(string) | no | {} | A map of tag names and values. | If there are any Defined Tags that you'd like assigned by default to all resources (unless otherwise overridden at the resource), set these here. |
| default\_freeform\_tags | map(string) | no | {} | A map of tag names and values. | If there are any Freeform Tags that you'd like assigned by default to all resources (unless otherwise overridden at the resource), set these here. |
| security\_lists | map | no | see below | see below | The parameters used to define and customize the Security List(s). |
| nsgs | map | no | see below | see below | The parameters used to define and customize the Network Security Group(s) (NSGs). |
| standalone_nsg_rules | map | no | see below | see below | The parameters used to define and customize any Network Security Group(s) (NSGs) that might belong to NSGs that are not managed by this module. |

### security_lists

The `security_lists` attribute is an optional map object attribute.  Note that if this attribute is used, all keys/values must be specified (Terraform does not allow for default or optional map keys/values).

Each entry's key specifies the name to be given to the Security List, with its attributes specified as values in a sub-map.

Each entry has the following defined keys (and default values):

| Key | Data Type | Default Value | Valid Values | Description |
|---|---|---|---|---|
| compartment\_id | string | default\_compartment\_id | Compartment OCID | Pre-existing compartment OCID (if default compartment is not to be used).  If this value is null, the default compartment OCID will be used. |
| defined\_tags | map(string) | no | var.default_defined_tags | A map of tag names and values. | If there are any Defined Tags that you'd like assigned to this resource, specify them here (otherwise the default Defined Tags will be used). |
| freeform\_tags | map(string) | no | var.default_freeform_tags | A map of tag names and values. | If there are any Freeform Tags that you'd like assigned to this resource, specify them here (otherwise the default Defined Tags will be used). |
| ingress\_rules | list of maps | [] | See definition below | Specify the ingress\_rules to be used (zero or more). |
| egress\_rules | list of maps | [] | See definition below | Specify the egress\_rules to be used (zero or more). |

**ingress_rules:**

| Key | Data Type | Default Value | Valid Values | Description |
|---|---|---|---|---|
| stateless | bool | none | true/false | Whether or not the rule should be stateless (true) or stateful (false). |
| protocol | string | none | "all" or valid IP protocol number | The IP protocol number (or "all" for all protocols) to be used for this rule. |
| src | string | none | CIDR | The IPv4 CIDR to be used for the rule. |
| src_type | string | none | *CIDR_BLOCK*, *SERVICE_CIDR_BLOCK* | The type of CIDR block that is specified. |
| src_port | map: {min, max} | none | The range of source ports to use for the rule. |
| dst_port | map: {min, max} | none | The range of destination ports to use for the rule. |
| icmp_type | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP type. |
| icmp_code | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP code. |

**egress_rules:**

| Key | Data Type | Default Value | Valid Values | Description |
|---|---|---|---|---|
| stateless | bool | none | true/false | Whether or not the rule should be stateless (true) or stateful (false). |
| protocol | string | none | "all" or valid IP protocol number | The IP protocol number (or "all" for all protocols) to be used for this rule. |
| dst | string | none | CIDR | The IPv4 CIDR to be used for the rule. |
| dst_type | string | none | *CIDR_BLOCK*, *SERVICE_CIDR_BLOCK* | The type of CIDR block that is specified. |
| src_port | map: {min, max} | none | The range of source ports to use for the rule. |
| dst_port | map: {min, max} | none | The range of destination ports to use for the rule. |
| icmp_type | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP type. |
| icmp_code | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP code. |

**Example**

```
module "oci_security_policy" {
  ... /snip - shortened for brevity...

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
    }
  }
}
```

The above example will create a single Security List, called *vcn*, using the default compartment OCID (not shown in the above example), having three egress rules.

#### nsgs

The `nsgs` attribute is an optional map object attribute.  Note that if this attribute is used, all keys/values must be specified (Terraform does not allow for default or optional map keys/values).

Each entry's key specifies the name to be given to the Network Security Group (NSG), with its attributes specified as values in a sub-map.

Each entry has the following defined keys (and default values):

| Key | Data Type | Default Value | Valid Values | Description |
|---|---|---|---|---|
| compartment\_id | string | default\_compartment\_id | Compartment OCID | Pre-existing compartment OCID (if default compartment is not to be used).  If this value is null, the default compartment OCID will be used. |
| defined\_tags | map(string) | no | var.default_defined_tags | A map of tag names and values. | If there are any Defined Tags that you'd like assigned to this resource, specify them here (otherwise the default Defined Tags will be used). |
| freeform\_tags | map(string) | no | var.default_freeform_tags | A map of tag names and values. | If there are any Freeform Tags that you'd like assigned to this resource, specify them here (otherwise the default Defined Tags will be used). |
| ingress\_rules | list of maps | [] | See definition below | Specify the ingress\_rules to be used (zero or more). |
| egress\_rules | list of maps | [] | See definition below | Specify the egress\_rules to be used (zero or more). |

**ingress_rules:**

| Key | Data Type | Default Value | Valid Values | Description |
|---|---|---|---|---|
| description | string | none | Any valid string accepted by the OCI API. | This is an optional parameter, which allows for a description to be set for the rule. |
| stateless | bool | none | true/false | Whether or not the rule should be stateless (true) or stateful (false). |
| protocol | string | none | "all" or valid IP protocol number | The IP protocol number (or "all" for all protocols) to be used for this rule. |
| src | string | none | CIDR | The IPv4 CIDR to be used for the rule. |
| src\_type | string | none | *CIDR_BLOCK*, *SERVICE_CIDR_BLOCK*, *NETWORK_SECURITY_GROUP*, *NSG_NAME* | The type of source that is to be used.  Note that if *NSG_NAME* is used, an NSG name is to be given in the `src` attribute, with the module looking up the value of the pre-existing NSG (getting the OCID from the NSG name given) and the actual type given to the OCI API will be *NETWORK_SECURITY_GROUP*.  *NSG_NAME* is essentially a shortcut, that allows for the name of an NSG (instead of its OCID, as is normally required when using the *NETWORK_SECURITY_GROUP* type). |
| src\_port | map: {min, max} | none | The range of source ports to use for the rule. |
| dst\_port | map: {min, max} | none | The range of destination ports to use for the rule. |
| icmp\_type | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP type. |
| icmp\_code | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP code. |

**egress_rules:**

| Key | Data Type | Default Value | Valid Values | Description |
|---|---|---|---|---|
| description | string | none | Any valid string accepted by the OCI API. | This is an optional parameter, which allows for a description to be set for the rule. |
| stateless | bool | none | true/false | Whether or not the rule should be stateless (true) or stateful (false). |
| protocol | string | none | "all" or valid IP protocol number | The IP protocol number (or "all" for all protocols) to be used for this rule. |
| dst | string | none | CIDR | The IPv4 CIDR to be used for the rule. |
| dst\_type | string | none | *CIDR_BLOCK*, *SERVICE_CIDR_BLOCK*, *NETWORK_SECURITY_GROUP*, *NSG_NAME* | The type of source that is to be used.  Note that if *NSG_NAME* is used, an NSG name is to be given in the `dst` attribute, with the module looking up the value of the pre-existing NSG (getting the OCID from the NSG name given) and the actual type given to the OCI API will be *NETWORK_SECURITY_GROUP*.  *NSG_NAME* is essentially a shortcut, that allows for the name of an NSG (instead of its OCID, as is normally required when using the *NETWORK_SECURITY_GROUP* type). |
| src\_port | map: {min, max} | none | The range of source ports to use for the rule. |
| dst\_port | map: {min, max} | none | The range of destination ports to use for the rule. |
| icmp\_type | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP type. |
| icmp\_code | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP code. |

**Example**

```
module "oci_security_policies" {
  ... /snip - shortened for brevity...

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
```

The above example will create a NSG with a name of *db*, having one ingress rule and one egress rule, using the default compartment OCID (not shown in the above example).

#### standalone_nsg_rules

The `standalone_nsg_rules` attribute is an optional map attribute used to manage NSGs rules for NSGs that are not created and managed by this module.  A primary use-case is when one or more NSG rules need to be added to an NSG that's defined outside of the scope of this module.  Note that if this attribute is used, all keys/values must be specified (Terraform does not allow for default or optional map keys/values).

Ingress and egress NSG rules may be managed, with its attributes specified as values in a sub-map.

The `standalone_nsg_rules` attribute has the following defined keys (and default values):

| Key | Data Type | Default Value | Valid Values | Description |
|---|---|---|---|---|
| ingress\_rules | list of maps | [] | See definition below | Specify the ingress\_rules to be used (zero or more). |
| egress\_rules | list of maps | [] | See definition below | Specify the egress\_rules to be used (zero or more). |

**ingress_rules:**

| Key | Data Type | Default Value | Valid Values | Description |
|---|---|---|---|---|
| nsg\_id | string | none | The OCID of a pre-existing NSG | Any valid NSG OCID. | This is the OCID of the NSG that the security rule will be placed in.  The NSG must be pre-existing. |
| description | string | none | Any valid string accepted by the OCI API. | This is an optional parameter, which allows for a description to be set for the rule. |
| stateless | bool | none | true/false | Whether or not the rule should be stateless (true) or stateful (false). |
| protocol | string | none | "all" or valid IP protocol number | The IP protocol number (or "all" for all protocols) to be used for this rule. |
| src | string | none | CIDR | The IPv4 CIDR to be used for the rule. |
| src\_type | string | none | *CIDR_BLOCK*, *SERVICE_CIDR_BLOCK*, *NETWORK_SECURITY_GROUP*, *NSG_NAME* | The type of source that is to be used.  Note that if *NSG_NAME* is used, an NSG name is to be given in the `src` attribute, with the module looking up the value of the pre-existing NSG (getting the OCID from the NSG name given) and the actual type given to the OCI API will be *NETWORK_SECURITY_GROUP*.  *NSG_NAME* is essentially a shortcut, that allows for the name of an NSG (instead of its OCID, as is normally required when using the *NETWORK_SECURITY_GROUP* type). |
| src\_port | map: {min, max} | none | The range of source ports to use for the rule. |
| dst\_port | map: {min, max} | none | The range of destination ports to use for the rule. |
| icmp\_type | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP type. |
| icmp\_code | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP code. |

**egress_rules:**

| Key | Data Type | Default Value | Valid Values | Description |
|---|---|---|---|---|
| nsg\_id | string | none | The OCID of a pre-existing NSG | Any valid NSG OCID. | This is the OCID of the NSG that the security rule will be placed in.  The NSG must be pre-existing. |
| description | string | none | Any valid string accepted by the OCI API. | This is an optional parameter, which allows for a description to be set for the rule. |
| stateless | bool | none | true/false | Whether or not the rule should be stateless (true) or stateful (false). |
| protocol | string | none | "all" or valid IP protocol number | The IP protocol number (or "all" for all protocols) to be used for this rule. |
| dst | string | none | CIDR | The IPv4 CIDR to be used for the rule. |
| dst\_type | string | none | *CIDR_BLOCK*, *SERVICE_CIDR_BLOCK*, *NETWORK_SECURITY_GROUP*, *NSG_NAME* | The type of source that is to be used.  Note that if *NSG_NAME* is used, an NSG name is to be given in the `dst` attribute, with the module looking up the value of the pre-existing NSG (getting the OCID from the NSG name given) and the actual type given to the OCI API will be *NETWORK_SECURITY_GROUP*.  *NSG_NAME* is essentially a shortcut, that allows for the name of an NSG (instead of its OCID, as is normally required when using the *NETWORK_SECURITY_GROUP* type). |
| src\_port | map: {min, max} | none | The range of source ports to use for the rule. |
| dst\_port | map: {min, max} | none | The range of destination ports to use for the rule. |
| icmp\_type | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP type. |
| icmp\_code | number | none | If ICMP is used as the protocol (protocol = 1), this can be used to narrow the specific ICMP code. |

**Example**

```
module "oci_security_policies" {
  ... /snip - shortened for brevity...

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
```

The above example will create a NSG with a name of *db*, having one ingress rule and one egress rule, using the default compartment OCID (not shown in the above example).

### Outputs

A map containing each subnet is returned in the *security_lists* output.  The outer map key is the name of the subnet, with all subnet attributes (as a map) being returned as the value.

A map of all NSGs is returned in the *nsgs* output.

A compilation of all NSG rules are returned in the *nsg_rules* output as a list, while the *nsg_ingress_rules* output provides only the ingress NSG rules (as a list) and the *nsg_egress_rules* provides only the egress NSG rules (also as a list).

## Notes/Issues

* Note that if you provide any single element in the different resource maps (`security_lists`, `nsgs`, etc), you must provide all of them.  Maps do not have a notion of an optional (or default value) for keys within the map, requiring that all keys/values be passed (if one key is passed, all keys must be passed).

## Release Notes

See [./docs/release_notes.md](release notes) for release notes information.

## URLs

* Nothing at this time

## Contributing

This project is open source. Oracle appreciates any contributions that are made by the open source community.

## License

Copyright (c) 2020 Oracle and/or its affiliates.

Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

See [LICENSE](LICENSE) for more details.
