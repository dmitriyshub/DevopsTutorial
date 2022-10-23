#!/bin/bash 
sudo apt-get update
sudo apt-get install software-properties-common -y 
sudo apt-add-repository ppa:ansible/ansible  
sudo apt-get update  
sudo apt-get install ansible -y 
sudo apt install default-jre -y
sudo apt install default-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update 
#sudo dpkg --configure -a
sudo apt-get install jenkins -y 
sudo apt-get install awscli -y