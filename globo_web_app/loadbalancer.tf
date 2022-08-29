## aws_elb_service_account
data "aws_elb_service_account" "root" {}
## aws_lb 
resource "aws_lb" "nginx" {
  name               = "${local.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.subnets[*].id

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.web_bucket.bucket
    prefix  = "alb-logs"
    enabled = true
  }

  tags = merge(local.common_tags, {
      Name  = "${local.name_prefix}-globo-web-alb"
    })

}
## aws_lb_target_group

resource "aws_lb_target_group" "nginx" {
  name     = "nginx-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  tags = merge(local.common_tags, {
      Name  = "${local.name_prefix}-nginx-alb-tg"
    })
}

## aws_lb_listener

resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    #sends action to target group
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

  tags = merge(local.common_tags, {
      Name  = "${local.name_prefix}-nginx-alb-listener"
    })

}

## aws_lb_target_group_attachment
#members of the group
resource "aws_lb_target_group_attachment" "nginxs" {
  count            = var.aws_instance_count
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginxs[count.index].id
  port             = 80
}
