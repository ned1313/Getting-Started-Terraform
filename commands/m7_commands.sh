# Let's test out the use of functions!
# You actually need to initialize the config before terraform console will work.
terraform init

terraform console

# Now we can try some different functions and syntax
min(42,5,16)
cidrsubnet(var.vpc_cidr_block, 8, 0)
cidrhost(cidrsubnet(var.vpc_cidr_block, 8, 0),5)
lookup(local.common_tags, "company", "Unknown")
lookup(local.common_tags, "missing", "Unknown")
local.s3_bucket_name

# Update the configuration by adding count and for_each loops and
# adding functions where helpful.

terraform validate
terraform fmt
terraform plan -out m7.tfplan
terraform apply m7.tfplan