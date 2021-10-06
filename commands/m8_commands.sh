# Modules are a powerful tool to group data sources and resources together
# into a logical unit that can be reused and distributed. Let's make use
# of the official VPC module on the Terraform registry and a module we
# write ourselves for s3 resources associated with web applications.

terraform validate
terraform fmt
terraform plan -out m8.tfplan
terraform apply m8.tfplan