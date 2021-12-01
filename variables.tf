variable "cidr" {
  type        = string
  description = "Internal network range for entire VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  type        = list(string)
  description = "Network ranges for public subnets created in the VPC. Devices in public subnets can be public facing and communicate to internet through an Internet Gateway."
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  validation {
    condition     = length(var.private_subnets) >= 2
    error_message = "A network requires at least 2 public subnets for public-facing AWS services to function properly."
  }
}

variable "private_subnets" {
  type        = list(string)
  description = "Network ranges for private subnets created in the VPC. Devices in private subnets communicate to internet through a NAT Gateway."
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  validation {
    condition     = length(var.private_subnets) >= 2
    error_message = "A network requires at least 2 private subnets for other AWS services to function properly."
  }
}

variable "intra_subnets" {
  type        = list(string)
  description = "Network ranges for intra subnets created in the VPC. Devices in intra subnets cannot access the internet directly."
  default     = []
}

variable "service_namespace" {
  type        = string
  description = <<EOF
Private DNS Domain to register in the network that is used to attach dynamically allocated services. (e.g. containers)
EOF
  default     = "service"
}

variable "enable_vpc_endpoints" {
  type        = bool
  default     = false
  description = <<EOF
Enable secure communication to encryption keys, secrets, and docker images.
This adds ~$1/day for each private subnet, ~$90/month for 3 subnets.
EOF
}
