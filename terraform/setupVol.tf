// Configuring the external volume
# resource "null_resource" "setupVol" {
#   depends_on = [
#     aws_volume_attachment.myWebVolAttach,
#   ]
#   //
#   provisioner "local-exec" {
#     command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key ~/.ssh/${var.key_name}.pem -i '${aws_instance.myWebOS.public_ip},' master.yml"
#   }
# }


// Configuring the external volume
resource "null_resource" "setupVol" {
  depends_on = [
    aws_efs_mount_target.mountefs,
    aws_cloudfront_distribution.s3_distribution,
  ]

  //
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key /home/dimash/Temp/${var.key_name}.pem -i '${aws_instance.myWebOS.public_ip},' master2.yml -e 'file_sys_id=${aws_efs_file_system.myWebEFS.id}'"
  }
}

// Configuring the external volume
resource "null_resource" "setupVol2" {
  depends_on = [
    null_resource.setupVol,
  ]

  //
  provisioner "local-exec2" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key /home/dimash/Temp/${var.key_name}.pem -i '${aws_instance.myWebOS.public_ip},' master3.yml --extra-vars \"file_system_dns=${aws_efs_file_system.myWebEFS.dns_name}\""
  }
}