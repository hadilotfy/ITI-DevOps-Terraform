

variable "public_ec2s_per_subnet" { type = number}
variable "private_ec2s_per_subnet" { type = number}

variable "public_ec2_user_data" { type = string}
variable "private_ec2_user_data" { type = string}

variable "ec2_ami" { 
    type = string
    default = data.aws_ami.rhel.id
}
variable "ec2_type" { type = string}
variable "ec2_vol_size" { type = number}
variable "ec2_replace_on_data_change" { type = bool}
variable "ec2_key_name" { type = string }

variable "sg_http_port" {   type = number }
variable "sg_http_protocol" {   type = string }
variable "sg_http_cidrs" {   type = list(string) }

variable "sg_https_port" {   type = number }
variable "sg_https_protocol" {   type = string }
variable "sg_https_cidrs" {   type = list(string) }

variable "sg_ssh_port" {   type = number }
variable "sg_ssh_protocol" {   type = string }
variable "sg_ssh_cidrs" {   type = list(string) }

variable "sg_egress_from_port" {   type = number }
variable "sg_egress_to_port" {   type = number }
variable "sg_egress_protocol" {   type = string }
variable "sg_egress_cidrs" {   type = list(string) }
