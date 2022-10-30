// Launching new EC2 instance
resource "aws_instance" "myWebOS" {
    ami = "ami-09d3b3274b6c5d4aa"
    instance_type = "t2.micro"
    key_name = "my_key"
    vpc_security_group_ids = ["${aws_security_group.allow_tcp.id}"]
    subnet_id = aws_subnet.vpc_subnet1_public.id
    tags = {
        Name = "webOS"
    }
}
/*
// Launching Jenkins EC2 instance
resource "aws_instance" "myJenkins" {
    ami = "ami-0e715ffa270f2c915"
    instance_type = "t2.micro"
    key_name = "my_key"
    vpc_security_group_ids = ["${aws_security_group.allow_tcp.id}"]
    subnet_id = aws_subnet.vpc_subnet1_public.id
    tags = {
        Name = "Jenkins"
    }
}
*/
// Creating EBS volume
# resource "aws_ebs_volume" "myWebVol" {
#   availability_zone = "${aws_instance.myWebOS.availability_zone}"
#   size              = 1

#   tags = {
#       Name = "ebs-vol"
#       Pro = var.my_tag
#       Env = var.my_tag_env
#   }
# }

# // Attaching above volume to the EC2 instance
# resource "aws_volume_attachment" "myWebVolAttach" {
#   depends_on = [
#         aws_ebs_volume.myWebVol,
#   ]

#   device_name = "/dev/sdc"
#   volume_id = "${aws_ebs_volume.myWebVol.id}"
#   instance_id = "${aws_instance.myWebOS.id}"
#   skip_destroy = true
# }








// Creating EFS
resource "aws_efs_file_system" "myWebEFS" {
  creation_token = "myWebFile"

  tags = {
      Name = "efs-vol"
      Pro = var.my_tag
      Env = var.my_tag_env
  }
}

// Mounting EFS
resource "aws_efs_mount_target" "mountefs" {
  file_system_id  = "${aws_efs_file_system.myWebEFS.id}"
  subnet_id       = aws_subnet.vpc_subnet1_public.id
  security_groups = ["${aws_security_group.allow_tcp.id}",]
}

output "efs_id" {
  value = aws_efs_file_system.myWebEFS.id
}
