**2023-06-02**

Partial Course Update

This is a revision of the previous course using Terraform 1.4. The exercises and content of the course have changed based on feedback and updates to the behavior and features available in Terraform.

I have removed some content and I am moving it to *Terraform - Deep Dive*. I also added more context around state data and how Terraform decides to create, update, and delete resources based on configuration, state, and the target environment.

The previous version of the course will remain available under branch `v3`.

* Updated course to use version 4.X of AWS provider
* Removed module 9 of the course that dealt with workspaces
* Rewrote s3.tf to use new AWS resources
* Changed resource naming to be more descriptive
* Updated variable names to be more accurate
* Moved website content to a local value
* Updated version of VPC module being used

**2021-10-07**

Full Course Update

This is a revision of the entire course using Terraform version 1.x. The exercises and content of the course have changed based on feedback and what I've learned presenting Terraform to user groups and individuals. Here are the major changes:

* Removed the AzureRM provider from the course
* Removed the need to supply EC2 Key Pairs
* Removed the use of the default VPC
* Switched from Classic ELB to an Application Load Balancer
* Removed the use of file and remote provisioners

Many of the removals are meant to simplify the learning process by removing common stumbling blocks. The provisioners were removed b/c HashiCorp now strongly discourages them. They will still be discussed in the course, but not used in the demos. 

**2020-12-21**

Updated for Terraform version 0.14.3:

* Add detail to README on how to create an Azure service principal
* Added comments to `terraform.tfvars.example` files to improve usability
* Added `.gitignore` exception for `.hcl`files, since Terraform 0.14 now creates these to lock provider versions
* Updated information about the certification guide
* Moved `terraform init` in module 6 due to changes in `terraform console`
* Added environment variable directions for Bash in module 7
* Added `required_providers` block to `terraform` block to set required version of Azure RM provider
* Added `features` block and `skip_provider_registration` to Azure RM provider config