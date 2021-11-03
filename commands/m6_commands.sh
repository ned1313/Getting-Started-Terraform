# Instead of storing our AWS keys in input variables, we will instead store
# them in environment variables. The AWS provider will check for values
# stored in AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.

# For Linux and MacOS
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_ACCESS_KEY

# For PowerShell
$env:AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
$env:AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"

# Now we can remove the variables from our configuration

# Once the updates are complete we'll run the standard workflow
terraform fmt

terraform init
terraform validate

terraform plan -out m6.tfplan
terraform apply m6.tfplan

