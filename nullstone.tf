terraform {
  required_providers {
    ns = {
      source = "nullstone-io/ns"
    }
  }
}

data "ns_workspace" "this" {}

resource "random_string" "resource_suffix" {
  length  = 5
  lower   = true
  upper   = false
  number  = false
  special = false
}

locals {
  resource_name = "${data.ns_workspace.this.block_ref}-${random_string.resource_suffix.result}"
  tags          = data.ns_workspace.this.tags
}
