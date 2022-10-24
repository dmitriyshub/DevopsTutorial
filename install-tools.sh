#!/bin/bash 
# sudo apt-get update -y
# sudo apt-get install software-properties-common -y 
# sudo apt-add-repository ppa:ansible/ansible -y 
# sudo apt-get update -y
# sudo apt-get install ansible -y 
# sudo apt-get install default-jre -y
# sudo apt-get install default-jdk -y
# sudo apt-get install awscli -y
# #dpkg --configure -a

# wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
# sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
# sudo apt-get update -y
# sudo apt-get install jenkins -y
# sudo systemctl enable jenkins.service
# sudo systemctl start jenkins.service
# # #sudo dpkg --configure -a

sudo apt-get update
sudo apt-get install software-properties-common -y 
sudo apt-add-repository ppa:ansible/ansible 
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update  
sudo apt-get install ansible -y 
sudo apt-get install fontconfig openjdk-11-jre -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' 
sudo apt-get update 
sudo apt-get install jenkins -y 
sudo apt-get install awscli -y

 #docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update
sudo apt install docker-ce -y
sudo usermod -aG docker ${USER}
sudo usermod -aG docker jenkins
sudo systemctl enable docker
sudo apt install git -y