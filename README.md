# block-aws-network

Nullstone Block standing up an AWS network configured with IPv6 enabled, and public and private subnets across 3 AZs.

## Inputs

- `stack_name: string` - Stack
- `env: string` - Environment

## Outputs

- `vpc_id: string` - VPC ID

- `public_subnet_ids: list(string)` 
  - IDs of all public subnets 
  - resources in this subnet are available to the internet (assuming they have a public IP)

- `private_subnet_ids: list(string)`
  - IDs of all private subnets
  - resources in these subnets have all egress access to internet