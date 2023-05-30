
######  Public lb
## Loadbalancer
resource "aws_lb" "public_lb" {
  name               = "webserver-public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
 # two ways to get a list of subnets ips:
 # subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]
 subnets             = var.public_subnets_ids 
}

## Target Group
resource "aws_lb_target_group" "public_lb_tg" {
    vpc_id = var.vpc_id
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
      target_group_arn = aws_lb_target_group.public_lb_tg.arn
    }
}
## TG. Attachment to instances
resource "aws_lb_target_group_attachment" "public_tg_attarch" {
    target_group_arn = aws_lb_target_group.public_lb_tg.arn
    count = length(var.public_ec2s_ids)  
    target_id = var.public_ec2s_ids[count.index]
    port = 80
}

######  Private lb
## Loadbalancer
resource "aws_lb" "private_lb" {
  name               = "webserver-private-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
 # two ways to get a list of subnets ips:
 # subnets            = [for subnet in var.private_subnets_ids : subnet.id]
 subnets             = var.private_subnets_ids 
}

## Target Group
resource "aws_lb_target_group" "private_lb_tg" {
    vpc_id = var.vpc_id
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
    count = length(var.private_ec2s_ids)
    target_id = var.private_ec2s_ids[count.index]
    port = 80
}
