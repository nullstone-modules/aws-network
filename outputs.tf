output "vpc_id" {
  value = module.network.vpc_id
}

output "vpc_cidr" {
  value = module.network.vpc_cidr_block
}

output "public_subnet_ids" {
  value = module.network.public_subnets
}

output "public_cidrs" {
  value = module.network.public_subnets_cidr_blocks
}

output "private_subnet_ids" {
  value = module.network.private_subnets
}

output "private_cidrs" {
  value = module.network.private_subnets_cidr_blocks
}

output "intra_subnet_ids" {
  value = module.network.intra_subnets
}

output "intra_cidrs" {
  value = module.network.intra_subnets_cidr_blocks
}
