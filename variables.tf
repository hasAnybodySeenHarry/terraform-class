variable "server_name" {
  type        = string
  description = "The name of the server to create"
  default     = "my server"
  validation {
    condition     = length(var.server_name) > 7 && length(var.server_name) < 20
    error_message = "Must be between 7 and 20 characters"
  }
}
