# Now we are going to start refactoring by adding some variables
# and local values to our configuration. This makes it more reusable
# and simplifies configuration updates.
terraform init
terraform validate
terraform plan -out m4.tfplan
terraform apply "m4.tfplan"

terraform show
terraform output

# You can always tear it down to save $$
terraform destroy