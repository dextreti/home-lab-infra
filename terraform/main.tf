# terraform/main.tf

terraform {
  required_version = ">= 1.0.0"
}

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
      "echo '--- 1. STARTING K3S INSTALLATION ---'",
      
      # Download and Install K3s (using the password for sudo)
      "echo ${var.ssh_password} | sudo -S sh -c 'curl -sfL https://get.k3s.io | sh -'",
      
      "echo '--- 2. WAITING FOR CLUSTER TO START ---'",
      "sleep 15",

      # Configure permissions so 'dextre' can use kubectl without sudo
      "echo '--- 3. CONFIGURING PERMISSIONS ---'",
      "echo ${var.ssh_password} | sudo -S chmod 644 /etc/rancher/k3s/k3s.yaml",
      "mkdir -p ~/.kube",
      "cp /etc/rancher/k3s/k3s.yaml ~/.kube/config",
      
      "echo '--- SUCCESS: K3s INSTALLED & CONFIGURED ---'"
    ]
  }
}