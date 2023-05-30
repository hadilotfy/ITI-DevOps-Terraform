
# VPC
resource "aws_vpc" "vpc"{
    cidr_block = var.vpc_cidr
}
# igw
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}

## network                                                  ok
## loadbalancer                                             ok
## getting ami through data
## userdata updating    ?????????
## availability zones and subnets                           ok
## s3_bucket and remote files
## remote provisioning on public machines (atleast)
## moduling
## workspace web_server
