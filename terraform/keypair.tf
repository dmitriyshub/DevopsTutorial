resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ec2_private_key.private_key_pem}' > ~/.ssh/${var.key_name}.pem"
  }
}

resource "null_resource" "key-perm" {
  depends_on = [
    tls_private_key.ec2_private_key,
  ]
  provisioner "local-exec" {
    command = "chmod 400 ~/.ssh/${var.key_name}.pem"
  }
}
