
# public_ec2s_per_subnet = 1
# private_ec2s_per_subnet = 1
# public_ec2_user_data = <<EOF
# #!/bin/bash
# # install nginx
# yum install -y nginx &> /home/ec2-user/install_log_nginx
 
# # edit configuration file to redirect to loadbalancer.
# ##aws s3 cp   s3://lab4-bucket-html-files/original_nginx.conf /etc/nginx/nginx.conf
# rep='^ *include */etc/nginx/default.d/\*\.conf;.*'
# my_dns='${var.private_dns}}' # ??????????????????????????????????????????????????????????????????
# sed -i 's@'"$${rep}"'@  location / {proxy_pass '"$${my_dns}"';}@' /etc/nginx/nginx.conf

# # stop selinux  from interfering 
# # (so web server can redirect trafic)
# setsebool -P httpd_can_network_connect 1

# # run nginx
# systemctl enable --now nginx
# EOF

# private_ec2_user_data = <<EOF
# #!/bin/bash
# yum install -y httpd
# systemctl enable --now httpd
# EOF

# ec2_type = "t2.micro"
# ec2_vol_size = 10
# ec2_replace_on_data_change = true
# ec2_key_name = "aws_key"

# # rep='^ *include */etc/nginx/default.d/\*\.conf;.*'
# # my_dns='http://3.87.12.65/'
# # sed -i 's@'"${rep}"'@  location / {proxy_pass '"${my_dns}"';}@' /etc/nginx/nginx.conf

# #ec2_ami =  "ami-016eb5d644c333ccb"   # initialized using data in default value.
