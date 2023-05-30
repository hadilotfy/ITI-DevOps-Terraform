
# security group
resource "aws_security_group" "lab_sg" {
    vpc_id = var.vpc_id  #aws_vpc.vpc.id
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

