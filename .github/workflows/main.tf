# terraform/main.tf

terraform {
  required_version = ">= 1.0.0"
}

# 1. Install K3s (The Lightweight Kubernetes)
resource "null_resource" "install_k3s" {
  
  # This triggers the reinstall ONLY if the install script changes
  triggers = {
    always_run = "${timestamp()}" 
  }

  connection {
    type     = "ssh"
    user     = var.ssh_user
    password = var.ssh_password
    host     = var.host_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo '--- STARTING K3S INSTALLATION ---'",
      
      # 1. Download and Install K3s (using the password for sudo)
      "echo ${var.ssh_password} | sudo -S sh -c 'curl -sfL https://get.k3s.io | sh -'",
      
      # 2. Wait a moment for the cluster to start
      "sleep 10",

      # 3. Check if it is running
      "sudo systemctl status k3s --no-pager",

      # 4. Configure permissions so 'dextre' can use kubectl without sudo
      "echo ${var.ssh_password} | sudo -S chmod 644 /etc/rancher/k3s/k3s.yaml",
      
      "echo '--- SUCCESS: K3s INSTALLED ---'"
    ]
  }
}