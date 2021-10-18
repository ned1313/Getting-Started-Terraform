#Random ID for unique naming
resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

locals {
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
    environment  = terraform.workspace
  }

  name_prefix    = "${var.naming_prefix}-${terraform.workspace}"
  s3_bucket_name = lower("${local.name_prefix}-${random_integer.rand.result}")
}