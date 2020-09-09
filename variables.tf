variable "owner_id" {
  type = string
}

variable "stack_name" {
  type = string
}

variable "env" {
  type = string
}

variable "block_name" {
  type = string
}

// NOTE: This block requires no parent blocks
variable "parent_blocks" {
  type    = object({})
  default = {}
}

variable "backend_conn_str" {
  type = string
}


variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "intra_subnets" {
  type    = list(string)
  default = []
}
