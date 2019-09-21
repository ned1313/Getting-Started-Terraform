##################################################################################
# OUTPUT
##################################################################################

output "aws_elb_public_dns" {
  value = aws_elb.web.dns_name
}

output "cname_record_url" {
  value = "http://${local.env_name}-website.${var.dns_zone_name}"
}