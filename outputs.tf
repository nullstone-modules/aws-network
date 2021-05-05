output "vpc_id" {
  value       = module.network.vpc_id
  description = "string ||| "
}

output "vpc_cidr" {
  value       = module.network.vpc_cidr_block
  description = "string ||| "
}

output "public_subnet_ids" {
  value       = module.network.public_subnets
  description = "list(string) ||| "
}

output "public_cidrs" {
  value       = module.network.public_subnets_cidr_blocks
  description = "list(string) ||| "
}

output "private_subnet_ids" {
  value       = module.network.private_subnets
  description = "list(string) ||| "
}

output "private_cidrs" {
  value       = module.network.private_subnets_cidr_blocks
  description = "list(string) ||| "
}

output "intra_subnet_ids" {
  value       = module.network.intra_subnets
  description = "list(string) ||| "
}

output "intra_cidrs" {
  value       = module.network.intra_subnets_cidr_blocks
  description = "list(string) ||| "
}

output "internal_zone_id" {
  value       = aws_route53_zone.internal.zone_id
  description = "string ||| "
}

output "service_discovery_id" {
  value       = aws_service_discovery_private_dns_namespace.service.id
  description = "string ||| AWS ID for the Private DNS namespace created for this cluster."
}
