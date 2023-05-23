

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

###########################  Configure AWS  ###########
provider "aws" {
  profile = "terraform"
}

###############################    VPC    #############
###### vpc
resource "aws_vpc" "lab1_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Terra_Lab1_VPC"
  }
}

###### internet gateway
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.lab1_vpc.id
    tags = {
        Name = "Terra_lab1_gw"
    }
}

###### routetable
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.lab1_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
    tags  = { Name = "Terra_lab1_rt"}
}

###### subnet
resource "aws_subnet" "lab1_subnet" {
  vpc_id     = aws_vpc.lab1_vpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Terra_lab1_pub_subnet"
  }
}

###### routetable association
resource "aws_route_table_association" "a"{
    subnet_id = aws_subnet.lab1_subnet.id
    route_table_id = aws_route_table.rt.id
}

###### security group
resource "aws_security_group" "sg"{
    name = "Allowing http"
    description = "Allow http requests from outside"
    vpc_id     = aws_vpc.lab1_vpc.id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {Name = "Terra_lab1_sg"}
}

###############################    EC2    #############
###### ec2
resource "aws_instance" "lab1_ec2"{
    ami     = "ami-016eb5d644c333ccb"
    instance_type   = "t2.micro"
    root_block_device {
        volume_size = 10
    }
    subnet_id = aws_subnet.lab1_subnet.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = { Name = "Terra_EC2"}
    user_data = "${file("lab1_ec2_userdata.sh")}" 
    user_data_replace_on_change = true    
}




/*
By:  Hadi Lotfy
email: hadi.al.atally@gmail.com

*/













#    user_data_base64
#    user_data_replace_on_change
#    security_groups
#    associate_public_ip_address = True
#    ebs_block_device
#    key_name
#    launch_template
#    network_interface
