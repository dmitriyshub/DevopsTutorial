variable "region_name" {
    description = "my region name"
    default = "us-east-1"
}

variable "ec2_type" {
    description = "instance type"
    default = "t2.micro"
}

variable "ami_id" {
    description = "jenkins_ami_id"
    default = ""
}

variable "my_tag" {
    description = "terraform tag"
    default = "terraform"
}

variable "my_tag_env" {
    description = "env tag"
    default = "terraform"
}
