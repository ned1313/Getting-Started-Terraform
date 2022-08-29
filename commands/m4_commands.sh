# Now we are going to start refactoring by adding some variables
# and local values to our configuration. This makes it more reusable
# and simplifies configuration updates.
.\terraform init
.\terraform validate

# We will pass our variables at the command line
.\terraform plan -var=billing_code="ACCT8675309" -var=project="web-app" -var=aws_access_key="YOUR_ACCESS_KEY" -var=aws_secret_key="YOUR_SECRET_KEY" -out m4.tfplan

# Ugh that's unwieldy. Let's store our nonsensitive variables in a file called
# .\terraform.tfvars

# And we can store our sensitive data in environment variables like so
# For Linux and MacOS
export TF_VAR_aws_access_key=YOUR_ACCESS_KEY
export TF_VAR_aws_secret_key=YOUR_SECRET_KEY

# For PowerShell
# We add this using the terminal to store sensitive data
$env:TF_VAR_aws_access_key="AKIAW2FIAW4JLK553E2O"
$env:TF_VAR_aws_secret_key="vL9dzYaRBRBeqkgOIJDhHmq26ecYcfBQbmPWe3cd"

# Now we can run plan without all that extra stuff
# This stores the changes to a separate file type, which works to store changes
.\terraform plan -out m4.tfplan
#This commits said changes
.\terraform apply "m4.tfplan"

.\terraform show
.\terraform output

# You can always tear it down to save $$
.\terraform destroy