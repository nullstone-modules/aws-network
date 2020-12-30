# block-aws-network

Nullstone Block standing up an AWS network configured with IPv6 enabled, and public, private, and intra subnets across 3 AZs.

## Inputs

- `cidr: string`
  - Internal network range for entire VPC.
  - Default: `10.0.0.0/16`
- `public_subnets: list(string)`
  - Network ranges for public subnets created in the VPC. Devices in public subnets can be public facing and communicate to internet through an Internet Gateway.
  - Default: `["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]`
- `private_subnets: list(string)`
  - Network ranges for private subnets created in the VPC. Devices in private subnets communicate to internet through a NAT Gateway.
  - Default: `["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]`
- `intra_subnets: list(string)`
  - Network ranges for intra subnets created in the VPC. Devices in intra subnets cannot access the internet directly.
  - Default: `[]`

## Outputs

- `vpc_id: string` - VPC ID

- `vpc_cidr: string` - VPC CIDR

- `public_subnet_ids: list(string)` 
  - IDs of all public subnets 
  - resources in this subnet are available to the internet (assuming they have a public IP)

- `public_cidrs: list(string)`
  - Network ranges of all public subnets

- `private_subnet_ids: list(string)`
  - IDs of all private subnets
  - resources in these subnets all have egress access to internet

- `private_cidrs: list(string)`
  - Network ranges of all private subnets

- `intra_subnet_ids: list(string)`
  - IDs of all intra subnets
  - resources in these subnets have no access to the internet

- `intra_cidrs: list(string)`
  - Network ranges of all intra subnets

- `internal_zone_id: string`
  - AWS Route53 Zone for private DNS zone that is only accessible inside the VPC.
  - Zone is configured as `internal` -- these are typically used to alias AWS services (e.g. `postgres.internal`)
