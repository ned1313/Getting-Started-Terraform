# You can find the installer info for Terraform here:
# https://www.terraform.io/downloads.html

# First we'll start by making sure Terraform is installed and check out the
# help command baked in to the cli.
terraform version

terraform -help

# Terraform follows the terraform <command> <subcommand> syntax
# Options use a single dash whether it's a single character option
# or full word.

# In this module, we are simply trying to get the configuration deployed.
# First we'll copy our file from the base_web_app to a working directory
mkdir globo_web_app
cp ./base_web_app/main.tf ./globo_web_app/main.tf

# Now we can work with the main.tf file in globo_web_app
cd globo_web_app

# Open the main.tf file in your code editor and replace the values 
# for the AWS keys in the config file

# !! DO NOT COMMIT THESE TO SOURCE CONTROL !!

# Now we will follow the standard Terraform workflow
terraform init
terraform plan -out m3.tfplan
terraform apply "m3.tfplan"

# Got to the Console and get the Public IP address for the EC2 instance
# and browse to port 80.

# If you are done, you can tear things down to save $$
terraform destroy