  ##################################################################################
  # OUTPUT
  ##################################################################################

  output "aws_elb_public_dns" {
    value = aws_elb.web.dns_name
  }

  output "cname_record_url" {
    value = "http://${var.environment_tag}-website.${var.dns_zone_name}"
  }