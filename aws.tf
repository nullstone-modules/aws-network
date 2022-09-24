provider "aws" {
  ignore_tags {
    key_prefixes = ["kubernetes.io/"]
  }
}
data "aws_availability_zones" "this" {}
