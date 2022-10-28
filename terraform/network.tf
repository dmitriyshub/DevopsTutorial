# VPC
resource "aws_vpc" "vpc" { # terraform id&name
  cidr_block = "172.16.0.0/16" # specify the network
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags = {
      Name = "VPC"
      Pro = var.my_tag
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
      Name = "PublicSubnet"
      Pro = var.my_tag
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
      Name = "PublicRouteTable"
      Pro = var.my_tag
      Env = var.my_tag_env
  }
}
# Internet Gateway for VPC
resource "aws_internet_gateway" "vpc_internet_gateway" { # terraform id&name
  vpc_id = aws_vpc.vpc.id # attach to vpc
  tags = {
      Name = "InternetGateway"
      Pro = var.my_tag
      Env = var.my_tag_env
  }
}
#################################################################
# Route Table Association PUBLIC
resource "aws_route_table_association" "subnet_public_assosiacion1" {
  subnet_id      = aws_subnet.vpc_subnet1_public.id
  route_table_id = aws_route_table.vpc_route_table_public.id
}




output "public_dns_WebOs" {
  value = "http://${aws_instance.myWebOS.public_dns}:80"
}

output "public_dns_Jenkins" {
  value = "http://${aws_instance.myJenkins.public_dns}:8080"
}