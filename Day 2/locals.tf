# computed vars to help in creating subnets
locals {
  pub_count = length(var.public_subnets_cidrs)
  pri_count = length(var.private_subnets_cidrs)
  subnets_count = local.pub_count + local.pri_count
}
