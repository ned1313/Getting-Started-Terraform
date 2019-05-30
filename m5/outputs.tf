##################################################################################
# OUTPUT
##################################################################################

output "aws_elb_public_dns" {
    value = "${aws_elb.web.dns_name}"
}

output "azure_rm_dns_cname" {
  value = "${azurerm_dns_cname_record.elb.id}"
}