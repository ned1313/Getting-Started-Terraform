#exposes values of modules and prints to console
#description = "Public DNS hostname web server"
#sensitive true means it doesn't print sensitivr info
#value = var.aws_cidr_block.subnet1

#F: http://globo-web-alb-745011480.us-east-1.elb.amazonaws.com/
#S: http://globo-web-alb-1065065858.us-east-1.elb.amazonaws.com/

output "aws_alb_public_dns" {
  value = "http://${aws_lb.nginx.dns_name}"
}