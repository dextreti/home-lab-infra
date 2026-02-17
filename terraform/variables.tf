# terraform/variables.tf

variable "ssh_password" {
  description = " The password for the debian user to run sudo commands"
  type        = string
  sensitive   = true # This ensures Terraform hides it in the logs
}

variable "ssh_user" {
  description = "The user to connect to the server"
  type        = string
  default     = "dextre"
}

variable "host_ip" {
  description = "The IP of the server"
  type        = string
  default     = "127.0.0.1" # Localhost, since the runner IS the server
}