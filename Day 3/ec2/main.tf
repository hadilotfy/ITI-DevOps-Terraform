###############################    EC2    #############
###### ec2


# public EC2.s
resource "aws_instance" "public_ec2s"{
    ami     = data.aws_ami.rhel.id
    instance_type   = var.ec2_type
    root_block_device {
        volume_size = var.ec2_vol_size
    }
    count = var.pub_sub_count * var.public_ec2s_per_subnet
    subnet_id = var.public_subnets_ids[count.index % length(var.public_subnets_ids)]
    vpc_security_group_ids = [var.sg_id]
    #user_data = var.public_ec2_user_data
    user_data_replace_on_change = var.ec2_replace_on_data_change
    key_name = var.ec2_key_name
    
    provisioner "local-exec" {
        command = "echo \" public  machine private ip = ${self.private_ip}  public ip = ${self.public_ip}\" >> ./ec2s_ips.txt"
    }
# sudo bash -c 'echo "<h1> Hello From Public EC2</h1>" >> health.html'
    provisioner "remote-exec" {
        inline = [
            "sudo yum install -y nginx ", #&> /home/ec2-user/install_log_nginx
            "rep='^ *include */etc/nginx/default.d/\\*\\.conf;.*'",
            "my_dns='${var.private_dns}'",
            "sudo sed -i 's@'\"$${rep}\"'@  location / {proxy_pass http://'\"$${my_dns}\"';}@' /etc/nginx/nginx.conf",
            "sudo setsebool -P httpd_can_network_connect 1",
            "sudo systemctl enable --now nginx"
        ]
    }
    connection {
        type = "ssh"
        host = self.public_ip
        user = "ec2-user"
        private_key = file("./aws_key2.pem")
        timeout = "4m"

    }


}
# private EC2.s
resource "aws_instance" "private_ec2s"{
    ami     = data.aws_ami.rhel.id
    instance_type   = var.ec2_type
    root_block_device {
        volume_size = var.ec2_vol_size
    }
    count = var.pri_sub_count * var.private_ec2s_per_subnet
    #subnet_id = aws_subnet.private_subnets[count.index].id
    subnet_id = var.private_subnets_ids[count.index % length(var.private_subnets_ids)]
    vpc_security_group_ids = [var.sg_id]
    user_data = var.private_ec2_user_data
    user_data_replace_on_change = var.ec2_replace_on_data_change
    key_name = var.ec2_key_name

    provisioner "local-exec" {
        command = "echo \" private machine private ip = ${self.private_ip}  public ip = ${self.public_ip}\" >> ./ec2s_ips.txt"
    }


}
