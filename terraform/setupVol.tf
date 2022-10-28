// Configuring the external volume
resource "null_resource" "setupVol" {
  depends_on = [
    aws_volume_attachment.myWebVolAttach,
  ]
  //
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key ~/.ssh/${var.key_name}.pem -i '${aws_instance.myWebOS.public_ip},' master.yml"
  }
}
