# terraform/main.tf

terraform {
  required_version = ">= 1.0.0"
}

# This is a "dummy" resource just to test the connection
resource "null_resource" "test_connection" {
  provisioner "local-exec" {
    command = "echo 'SUCCESS: Terraform is running on Debian Geekom!' > status.txt"
  }
}