
output "public_dns" {
  value = aws_lb.public_lb.dns_name
}
output "private_dns" {
  value = aws_lb.private_lb.dns_name
}
