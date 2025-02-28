variable "db_username" {
  type        = string
  description = "The username of the RDS database"

  validation {
    condition     = length(var.db_username) > 4 && length(var.db_username) < 12
    error_message = "Must be between 5 and 12 characters"
  }
}

variable "db_name" {
  type        = string
  description = "The name of the database to create"

  validation {
    condition     = length(var.db_name) > 4 && length(var.db_name) < 12
    error_message = "Must be between 5 and 12 characters"
  }
}

variable "db_password" {
  type        = string
  description = "The password of the RDS database"
  sensitive   = true

  validation {
    condition     = length(var.db_password) > 5 && length(var.db_password) < 12
    error_message = "Must be between 5 and 12 characters"
  }
}

variable "vpc_id" {
  type        = string
  description = "The VPC id to house the Postgres Database"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR range of the VPC housing the clients"
}
