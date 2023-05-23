

output "ec2s_ips" {
    value = {
        public_ips = aws_instance.my_ec2s.*.public_ip
        private_ips = aws_instance.my_ec2s.*.private_ip       
    }
}
