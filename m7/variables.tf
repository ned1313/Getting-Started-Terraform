##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {
  default = "PluralsightKeys"
}
variable "network_address_space" {
  default = "10.1.0.0/16"
}

variable "billing_code_tag" {}
variable "environment_tag" {}
variable "bucket_name" {}

variable "arm_subscription_id" {}
variable "arm_principal" {}
variable "arm_password" {}
variable "tenant_id" {}
variable "dns_zone_name" {}
variable "dns_resource_group" {}
variable "dns_site_name" {}

##################################################################################
# LOCALS
##################################################################################

locals {
  common_tags = {
    BillingCode = var.billing_code_tag
    Environment = var.environment_tag
  }

  s3_bucket_name = "${var.bucket_name_prefix}-${var.environment_tag}-${random_integer.rand.result}"

  network_address_space = {
    Development = "10.0.0.0/16"
    UAT = "10.1.0.0/16"
    Production = "10.2.0.0/16"
  }

  instance_size = {
    Development = "t2.micro"
    UAT = "t2.small"
    Production = "t2.medium"
  }

  subnet_count = {
    Development = 2
    UAT = 2
    Production = 3
  }

  instance_count = {
    Development = 2
    UAT = 4
    Production = 6
  }
}