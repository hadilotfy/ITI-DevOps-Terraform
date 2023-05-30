
output "public_dns_name" {
  value = module.lb.public_dns
}

output "public_ec2s_ids" {
  value = module.ec2s.public_ec2s_ids
}

output "private_ec2s_ids" {
  value = module.ec2s.private_ec2s_ids
}