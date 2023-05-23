
ec2s_per_subnet = 1

ec2_ami = "ami-016eb5d644c333ccb"
ec2_type = "t2.micro"
ec2_vol_size = 10
ec2_replace_on_data_change = true
ec2_user_data = <<EOF
#!/bin/bash
yum install -y httpd
systemctl enable --now httpd
EOF
ec2_key_name = "aws_key"

sg_http_port = 80
sg_http_protocol = "tcp"
sg_http_cidrs = ["0.0.0.0/0"]

sg_https_port = 443
sg_https_protocol = "tcp"
sg_https_cidrs = ["0.0.0.0/0"]

sg_ssh_port = 22
sg_ssh_protocol = "tcp"
sg_ssh_cidrs = ["0.0.0.0/0"]

sg_egress_from_port = 0
sg_egress_to_port = 0
sg_egress_protocol = "-1"
sg_egress_cidrs = ["0.0.0.0/0"]