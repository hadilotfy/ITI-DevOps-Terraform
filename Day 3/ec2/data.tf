
data "aws_ami" "rhel" {
    name_regex = "^RHEL-9.2.0_HVM-[0-9]*-x86_64"
}



# data "aws_ssm_parameter" "ami" {
#     name = "/aws/service/ami-amazon-linux-latest/"
# }

