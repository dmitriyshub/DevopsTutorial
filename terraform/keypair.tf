resource "tls_private_key" "ec2_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ec2_private_key.private_key_pem}' > /home/dimash/Temp/${var.key_name}.pem"
  }
}

resource "null_resource" "key-perm" {
  depends_on = [
    tls_private_key.ec2_private_key,
  ]
  provisioner "local-exec" {
    command = "chmod 400 /home/dimash/Temp/${var.key_name}.pem"
  }
}
module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "my_key"
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}