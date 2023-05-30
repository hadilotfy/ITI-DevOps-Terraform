
variable "vpc_id" { type = string}
variable "sg_id" { type = string }
variable "public_subnets_ids" {type = list(string)}
variable "private_subnets_ids" {type = list(string)}
variable "public_ec2s_ids"{type = list(string)}
variable "private_ec2s_ids"{type = list(string)}

