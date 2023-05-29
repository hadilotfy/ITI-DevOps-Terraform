###############################    EC2    #############
###### ec2


# public EC2.s
resource "aws_instance" "public_ec2s"{
    ami     = var.ec2_ami   # initialized using data in default value.
    instance_type   = var.ec2_type
    root_block_device {
        volume_size = var.ec2_vol_size
    }
    count = local.pub_sub_count * var.public_ec2s_per_subnet
    subnet_id = aws_subnet.public_subnets[count.index].id
    vpc_security_group_ids = [aws_security_group.lab_sg.id]
    user_data = var.public_ec2_user_data
    user_data_replace_on_change = var.ec2_replace_on_data_change
    key_name = var.ec2_key_name
}
# private EC2.s
resource "aws_instance" "private_ec2s"{
    ami     = var.ec2_ami
    instance_type   = var.ec2_type
    root_block_device {
        volume_size = var.ec2_vol_size
    }
    count = local.pri_sub_count * var.private_ec2s_per_subnet
    subnet_id = aws_subnet.private_subnets[count.index].id
    vpc_security_group_ids = [aws_security_group.lab_sg.id]
    user_data = var.private_ec2_user_data
    user_data_replace_on_change = var.ec2_replace_on_data_change
    key_name = var.ec2_key_name
}

# security group
resource "aws_security_group" "lab_sg" {
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = var.sg_http_port
        to_port = var.sg_http_port
        protocol =  var.sg_http_protocol
        cidr_blocks = var.sg_http_cidrs
    }
    ingress {
        from_port = var.sg_https_port
        to_port = var.sg_https_port
        protocol =  var.sg_https_protocol
        cidr_blocks = var.sg_https_cidrs
    }
    ingress {
        from_port = var.sg_ssh_port
        to_port = var.sg_ssh_port
        protocol =  var.sg_ssh_protocol
        cidr_blocks = var.sg_ssh_cidrs
    }
    egress {
        from_port = var.sg_egress_from_port
        to_port = var.sg_egress_to_port
        protocol = var.sg_egress_protocol
        cidr_blocks = var.sg_egress_cidrs
    }
}

