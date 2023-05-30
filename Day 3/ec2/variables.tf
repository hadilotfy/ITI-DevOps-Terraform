

variable "sg_id" { type = string }
variable "public_subnets_ids" {type = list(string)}
variable "private_subnets_ids" {type = list(string)}
variable "private_dns" {type = string}
variable "pri_sub_count" {type = number}
variable "pub_sub_count" {type = number}



variable "public_ec2s_per_subnet" { type = number}
variable "private_ec2s_per_subnet" { type = number}

#variable "public_ec2_user_data" { type = string}
variable "private_ec2_user_data" { type = string}

variable "ec2_type" { type = string}
variable "ec2_vol_size" { type = number}
variable "ec2_replace_on_data_change" { type = bool}
variable "ec2_key_name" { type = string }


