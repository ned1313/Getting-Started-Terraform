# Let's test out the use of functions!
# You actually need to initialize the config before terraform console will work.
terraform init

terraform console

# Now we can try some different functions and syntax
min(42,5,16)
lower("TACOCAT")
cidrsubnet(var.vpc_cidr_block, 8, 0)
cidrhost(cidrsubnet(var.vpc_cidr_block, 8, 0),5)
lookup(local.common_tags, "company", "Unknown")
lookup(local.common_tags, "missing", "Unknown")
local.common_tags

# Update the configuration by adding count and for_each loops and
# adding functions where helpful.

terraform fmt
terraform validate

# For Linux and MacOS
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_ACCESS_KEY

# For PowerShell
$env:AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
$env:AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"

terraform plan -out m7.tfplan
terraform apply m7.tfplan