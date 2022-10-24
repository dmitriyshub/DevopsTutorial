variable "region_name" {
    description = "my region name"
    default = "us-east-1"
}
variable "availability_zone" {
    description = "my az name"
    default = "us-east-1a"
  
}

variable "ec2_type" {
    description = "instance type"
    default = "t2.micro"
}

variable "ami_id" {
    description = "jenkins_ami_id"
    default = "ami-05375dec5f41f6727"
}

variable "my_tag" {
    description = "terraform tag"
    default = "terraform"
}

variable "my_tag_env" {
    description = "environment tag"
    default = "dev"
}
