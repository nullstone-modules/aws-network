resource "aws_service_discovery_private_dns_namespace" "service" {
  name = var.service_namespace
  vpc  = module.network.vpc_id
  tags = data.ns_workspace.this.tags
}
