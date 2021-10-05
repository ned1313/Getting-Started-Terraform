output "aws_alb_public_dns" {
  value = aws_lb.nginx.dns_name
}