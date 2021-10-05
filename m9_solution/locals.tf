#Random ID for unique naming
resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

locals {
  common_tags = {
    company = "Globomantics"
    project = "8675309"
  }

  name_prefix    = "${var.naming_prefix}-dev"
  s3_bucket_name = "${local.name_prefix}-${random_integer.rand.result}"
}