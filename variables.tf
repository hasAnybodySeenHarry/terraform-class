variable "server_config" {
  type = object({
    name = string,
    type = string,
  })
  description = "The configuration of the server to create"

  validation {
    condition     = length(var.server_config.name) > 7 && length(var.server_config.name) < 20
    error_message = "Must be between 7 and 20 characters"
  }

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.server_config.type)
    error_message = "Must be either t2.micro or t3.micro"
  }
}

variable "create_instance" {
  type        = bool
  description = "Whether to create the instance, default is true"
  default     = true
}

variable "server_count" {
  type        = number
  description = "The number of servers to create"
  default     = 1

  validation {
    condition     = var.server_count >= 0
    error_message = "Must be a positive number"
  }

  validation {
    condition     = var.server_count < 4
    error_message = "Must not exceed 3"
  }
}

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
