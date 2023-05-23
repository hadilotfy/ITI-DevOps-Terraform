
# VPC
resource "aws_vpc" "vpc"{
    cidr_block = var.vpc_cidr
}
# igw
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}
# elastic ip
resource "aws_eip" "eip" {
    vpc = var.eip_vpc
}
# ngw
resource "aws_nat_gateway" "ngw" {
    subnet_id = aws_subnet.the_subnets[var.pub_sub_index_to_put_ngw].id
    allocation_id = aws_eip.eip.id
}
# Public Routing Table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.public_rt_cidr
        gateway_id = aws_internet_gateway.igw.id
    }
}
# Private Routing Table
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.private_rt_cidr
        gateway_id = aws_nat_gateway.ngw.id
    }
}

# Subnets (both public and private in one go)
resource "aws_subnet" "the_subnets"{
    vpc_id = aws_vpc.vpc.id
    count = local.subnets_count
    cidr_block = count.index < local.pub_count ? var.public_subnets_cidrs[count.index] : var.private_subnets_cidrs[count.index - local.pub_count]
    map_public_ip_on_launch = count.index < local.pub_count ? true : false
}

# public rt associations
resource "aws_route_table_association" "public_rtas" {
    count = local.pub_count
    subnet_id =  aws_subnet.the_subnets[count.index].id
    route_table_id = aws_route_table.public_rt.id
}

# private rt associations
resource "aws_route_table_association" "private_rtas" {
    count = local.pri_count
    subnet_id =  aws_subnet.the_subnets[local.pub_count+count.index].id
    route_table_id = aws_route_table.private_rt.id
}