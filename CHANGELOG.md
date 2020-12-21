**2020-12-21**

Updated for Terraform version 0.14.3
* Add detail to README on how to create an Azure service principal
* Added comments to `terraform.tfvars.example` files to improve usability
* Added `.gitignore` exception for `.hcl`files, since Terraform 0.14 now creates these to lock provider versions
* Updated information about the certification guide
* Moved `terraform init` in module 6 due to changes in `terraform console`
* Added environment variable directions for Bash in module 7
* Added `required_providers` block to `terraform` block to set required version of Azure RM provider
* Added `features` block and `skip_provider_registration` to Azure RM provider config