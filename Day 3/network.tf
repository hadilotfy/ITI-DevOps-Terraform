
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
    subnet_id = aws_subnet.public_subnets[var.pub_sub_index_to_put_ngw].id
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

# Public Subnets
resource "aws_subnet" "public_subnets"{
    vpc_id = aws_vpc.vpc.id
    count = local.pub_sub_count
    cidr_block = var.public_subnets_cidrs[count.index]
    availability_zone_id = data.aws_availability_zones.azones.zone_ids[count % num_of_zones]
    map_public_ip_on_launch = var.public_subnet_mapPubIps
}

# Private Subnets
resource "aws_subnet" "private_subnets"{
    vpc_id = aws_vpc.vpc.id
    count = local.pri_sub_count
    cidr_block = var.private_subnets_cidrs[count.index]
    availability_zone_id = data.aws_availability_zones.azones.zone_ids[count % num_of_zones]
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

## network                                                  ok
## loadbalancer                                             ok
## getting ami through data
## userdata updating    ?????????
## availability zones and subnets                           ok
## s3_bucket and remote files
## remote provisioning on public machines (atleast)
## moduling
## workspace web_server
