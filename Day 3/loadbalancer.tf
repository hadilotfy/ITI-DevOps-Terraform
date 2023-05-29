
######  Public lb
## Loadbalancer
resource "aws_lb" "public_lb" {
  name               = "webserver_public_lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lab_sg.id]
 # two ways to get a list of subnets ips:
 # subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]
 subnets             = aws_subnet.public_subnets.*.id

}

## Target Group
resource "aws_lb_target_group" "public_lb_tg" {
    vpc_id = aws_vpc.vpc.id
    protocol = "HTTP"
    port = 80
}
## Listner
resource "aws_lb_listener" "public_lb_listner" {
    load_balancer_arn = aws_lb.public_lb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.public_lb_tg
    }
}
## TG. Attachment to instances
resource "aws_lb_target_group_attachment" "public_tg_attarch" {
    target_group_arn = aws_lb_target_group.public_lb_tg.arn
    count = length(aws_instance.public_ec2s)
    target_id = aws_instance.public_ec2s[count.index]
    port = 80
}

######  Private lb
## Loadbalancer
resource "aws_lb" "private_lb" {
  name               = "webserver_private_lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lab_sg.id]
 # two ways to get a list of subnets ips:
 # subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]
 subnets             = aws_subnet.private_subnets.*.id

}

## Target Group
resource "aws_lb_target_group" "private_lb_tg" {
    vpc_id = aws_vpc.vpc.id
    protocol = "HTTP"
    port = 80
}
## Listner
resource "aws_lb_listener" "private_lb_listner" {
    load_balancer_arn = aws_lb.private_lb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.private_lb_tg.arn
    }
}
## TG. Attachment to instances
resource "aws_lb_target_group_attachment" "private_tg_attarch" {
    target_group_arn = aws_lb_target_group.private_lb_tg.arn
    count = length(aws_instance.private_ec2s)
    target_id = aws_instance.private_ec2s[count.index].id
    port = 80
}
