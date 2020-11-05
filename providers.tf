terraform {
  required_providers {
    aws = {}
    ns = {
      source = "nullstone-io/ns"
    }
  }
}

data "aws_availability_zones" "this" {}
data "ns_workspace" "this" {}

data "ns_connection" "network" {
  type = "network"
}

-----
workspace
- parent_blocks: {
    "network": "network0@>=3.0.0"
}