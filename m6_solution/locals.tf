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

  s3_bucket_name = "globo-web-app-${random_integer.rand.result}"
}