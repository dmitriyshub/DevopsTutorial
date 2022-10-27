provider "aws" { 
        region = var.region_name 
} 
# VPC
resource "aws_vpc" "vpc" { # terraform id&name
  cidr_block = "172.16.0.0/16" # specify the network
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags = {
      Name = var.my_tag
      Env = var.my_tag_env
  }
}

# PUBLIC Subnet 1
resource "aws_subnet" "vpc_subnet1_public" { # terraform id&name
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.my_tag
    Env = var.my_tag_env
  }
}
# KEY PAIR
resource "aws_key_pair" "new_key" { 
  key_name= "jenkinskey" 
  public_key = "${file("jenkinskey.pub")}"
  tags = {
    Name = var.my_tag
    Env = var.my_tag_env
  }
} 
 # EC2
resource "aws_instance" "jenkins_ec2" { 
        ami = var.ami_id
        instance_type = var.ec2_type 
        key_name = "${aws_key_pair.new_key.key_name}"


        subnet_id = aws_subnet.vpc_subnet1_public.id # attach ec2 to subnet
        associate_public_ip_address = true # get automatic public ip
        #vpc_security_vpc_security_group_ids = [aws_security_group.public_security_group.id]
        security_groups = [aws_security_group.public_security_group.id]
        
        tags = { 
         Name = var.my_tag
         Env = var.my_tag_env 
        } 
}


#  Security Group
resource "aws_security_group" "public_security_group" { # terraform id&name
  name        = "Public security group"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id # attach security group to vpc

  dynamic "ingress" {
    for_each = ["8080","22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  # Outbound rule
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.my_tag
    Env = var.my_tag_env
  }
}

# Route Table for VPC PUBLIC
resource "aws_route_table" "vpc_route_table_public" {
  vpc_id = aws_vpc.vpc.id # attach to vpc

  route {
    cidr_block = "0.0.0.0/0" # ip range for this route
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id # attach to internet gateway
  }

  tags = {
    Name = var.my_tag
    Env = var.my_tag_env
  }
}
# Internet Gateway for VPC
resource "aws_internet_gateway" "vpc_internet_gateway" { # terraform id&name
  vpc_id = aws_vpc.vpc.id # attach to vpc
  tags = {
    Name = var.my_tag
    Env = var.my_tag_env
  }
}
#################################################################
# Route Table Association PUBLIC
resource "aws_route_table_association" "subnet_public_assosiacion1" {
  subnet_id      = aws_subnet.vpc_subnet1_public.id
  route_table_id = aws_route_table.vpc_route_table_public.id
}




output "public_dns" {
  value = "http://${aws_instance.jenkins_ec2.public_dns}:8080"
}

# resource "aws_s3_bucket" "s3_bucket" {
#   bucket = "my-tf-test-bucket"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }

# resource "aws_s3_bucket_acl" "s3_bucket_acl" {
#   bucket = aws_s3_bucket.s3_bucket.id
#   acl    = "private"
# }
# output "s3_domain_name" {
#     value = aws_s3_bucket.s3_bucket.bucket_domain_name
# }
# output "s3_arn" {
#     value = aws_s3_bucket.s3_bucket.arn
# }