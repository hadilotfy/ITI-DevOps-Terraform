variable "vpc_id" { type = string}

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
