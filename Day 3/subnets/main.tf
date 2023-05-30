# Public Subnets
resource "aws_subnet" "public_subnets"{
    vpc_id = var.vpc_id
    count = local.pub_sub_count
    cidr_block = var.public_subnets_cidrs[count.index]
    availability_zone = data.aws_availability_zones.azones.names[count.index % local.num_of_zones]
    map_public_ip_on_launch = var.public_subnet_mapPubIps
}

# Private Subnets
resource "aws_subnet" "private_subnets"{
    vpc_id = var.vpc_id
    count = local.pri_sub_count
    cidr_block = var.private_subnets_cidrs[count.index]
    availability_zone = data.aws_availability_zones.azones.names[count.index % local.num_of_zones]
}

# elastic ip
resource "aws_eip" "eip" {
    vpc = var.eip_vpc
}
# ngw
resource "aws_nat_gateway" "ngw" {
    subnet_id = aws_subnet.public_subnets[var.pub_sub_index_to_put_ngw].id
    allocation_id = aws_eip.eip.id
}
# Public Routing Table
resource "aws_route_table" "public_rt" {
    vpc_id = var.vpc_id
    route {
        cidr_block = var.public_rt_cidr
        gateway_id = var.vpc_igw_id
    }
}
# Private Routing Table
resource "aws_route_table" "private_rt" {
    vpc_id = var.vpc_id
    route {
        cidr_block = var.private_rt_cidr
        gateway_id = aws_nat_gateway.ngw.id
    }
}


# public rt associations
resource "aws_route_table_association" "public_rtas" {
    count = local.pub_sub_count
    subnet_id =  aws_subnet.public_subnets[count.index].id
    route_table_id = aws_route_table.public_rt.id
}

# private rt associations
resource "aws_route_table_association" "private_rtas" {
    count = local.pri_sub_count
    subnet_id =  aws_subnet.private_subnets[count.index].id
    route_table_id = aws_route_table.private_rt.id
}
