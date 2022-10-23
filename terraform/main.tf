provider "aws" { 

        region = "us-west-2" 
} 
resource "aws_key_pair" "new_key" { 
  key_name="jenkinskey" 
  public_key = "${file("jenkinskey.pub")}" 
} 
 
resource "aws_instance" "first_instance" { 
        ami = "ami-03fa27774f4d3442d" 
        instance_type = "t2.micro" 
        key_name = "${aws_key_pair.new_key.key_name}"
        
        tags = { 
         Name = "my-jenkins" 
        } 
}