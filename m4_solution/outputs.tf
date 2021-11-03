output "aws_instance_public_dns" {
  value = aws_instance.nginx1.public_dns
}