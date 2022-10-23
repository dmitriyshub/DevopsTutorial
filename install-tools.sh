#!/bin/bash 
sudo apt-get update -y
sudo apt-get install software-properties-common -y 
sudo apt-add-repository ppa:ansible/ansible  
sudo apt-get update -y
sudo apt-get install ansible -y 
sudo apt install openjdk-8-jre -y

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
#sudo dpkg --configure -a
sudo apt-get install awscli -y