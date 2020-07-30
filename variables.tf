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
