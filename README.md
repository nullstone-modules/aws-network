# block-aws-network

Nullstone Block standing up an AWS network configured with IPv6 enabled, and public and private subnets across 3 AZs.

## Global

There are no global resources created.

## Per Environment

## Inputs

- `owner_id: string` - Stack Owner ID
- `stack_name: string` - Stack Name
- `block_name: string` - Block Name (default: `network0`)
- `env: string` - Environment Name
- `backend_conn_str: string` - Connection string for postgres backend

## Outputs

- `vpc_id: string` - VPC ID

- `public_subnet_ids: list(string)` 
  - IDs of all public subnets 
  - resources in this subnet are available to the internet (assuming they have a public IP)

- `private_subnet_ids: list(string)`
  - IDs of all private subnets
  - resources in these subnets have all egress access to internet
