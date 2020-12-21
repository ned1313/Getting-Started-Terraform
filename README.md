# Getting-Started-Terraform

Welcome to Terraform - Getting Started.  These exercise files are meant to accompany my course on [Pluralsight](https://app.pluralsight.com/library/courses/terraform-getting-started).  The course was developed using version 0.12.5 of Terraform.  As far as I know there are no coming changes that will significantly impact the validity of these exercise files.  But I also don't control all the plug-ins, providers, and modules used by the configurations. 

**UPDATE** - 2020-12-21: The exercise files have been updated for compatibility with Terraform version 0.14.3. There are several changes in the default behavior of Terraform regarding plans, provider version locking, and diffs. Be sure to check out the full [CHANGELOG](https://github.com/hashicorp/terraform/blob/master/CHANGELOG.md) over on their GitHub for more details.

## Using the files

Each folder represents a module from the course and is completely self contained.  In each module there will be an example of the *tfvars* file that you will use named *terraform.tfvars.example*.  Simply update the contents of the file and rename it *terraform.tfvars*.  Due to the sensitive nature of the information you place in the *tfvars* file, **do not** check it into source control, especially a public repository.  Some of us - *read me* - have made that mistake before and had to delete AWS access keys post-haste.

Once you have updated and renamed the *tfvars* file(s), you can run the commands in the *m#_commands.txt* file, where the *#* is the number of the module.  Be sure to run the commands from the working directory of the module.  Or you can just noodle around on the terraform CLI and see what you can discover/break.  If you run into an issue, please submit it as such and I will do my best to remediate it.

## AWS Key Pairs

One of the most common issues reported by people is confusion over AWS Key Pairs and Regions.  The Terraform configurations make use of us-east-1 (N. Virginia) as the default region.  You can override that region by changing the default or submitting a different value for `var.region`.  The AWS Key Pair you use must be created in the same region you have selected for deployment.  You can create those keys from either the AWS EC2 Console or the AWS CLI.  If you are using the CLI, the process is very simple.

```console
aws configure set region your_region_name
aws ec2 create-key-pair --key-name your_key_name
```

The json output will include a KeyMaterial section.  Copy and paste the contents of the KeyMaterial section starting with `-----BEGIN RSA PRIVATE KEY-----` and ending with `-----END RSA PRIVATE KEY-----` to a file with a .pem extension.  Then point the *tfvars* entry for `private_key_path` to the full path for the file.

If you are using Windows, remember that the file path backslashes need to be doubled, since the single backslash is the escape character for other special characters.  For instance, the path `C:\Users\Ned\mykey.pem` should be entered as `C:\\Users\\Ned\\mykey.pem`.

## Azure Account

Some of the modules also include an Azure Account and public domain using the Azure DNS service. If you don't have a public domain, you can get an `xyz` domain for about $2. You can also just make up a domain like `tacos.local` and add it as an zone in Azure DNS. The resulting addresses won't be publicly accessible, but you'll at least get a feeling for how it would have worked. 

You can create a service principal in Azure by using the Cloud Shell and following the directions found in Microsoft's [documentation](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli). Make sure to grant the service principal Contributor permissions to the Azure DNS zone. I usually just give it Contributor permissions on the resource group holding the Azure DNS zone. The commands would be like this:

```bash
# Get the Subscription Id 
subId=$(az account show --query id -o tsv)
echo $subId
# Set the resource group with the Azure DNS zone in it
rg=DNS_RESOURCE_GROUP
az ad sp create-for-rbac \
  --name GettingStartedTerraform \
  --role Contributor \
  --scope /subscriptions/$subId/resourceGroups/$rg
```

Make a note of the `appId`, `password`, and `tenant` in the output. Also grab the subscription ID stored in the `$subId` variable.

I've been asked if you can do the whole thing with AWS Route 53 instead. You can! And that would be an excellent challenge to undertake with your new Terraform chops. I chose to include Azure to demonstrate the multicloud nature of Terraform.

## Line Endings

Another issue I have discovered from time to time is that Terraform doesn't much like the Windows style of ending a line with both a Carriage Return (CR) and a Line Feed (LF), commonly referred to as CRLF.  If you are experiencing strange parsing issues, change the line ending to be Line Feed (LF) only.  In VS Code this can be down by clicking on the CRLF in the lower right corner and changing it to LF.

## MONEY!!!

A gentle reminder about cost.  The course will have you creating resources in AWS and Azure.  Some of the resources are not going to be 100% free.  In most cases I have tried to use the [Free-tier](https://aws.amazon.com/free/) when possible, but in some cases I have elected to use a larger size EC2 instance to demonstrate the possibilities with multiple environments.  

The DNS zone in Azure is also not completely free.  You are going to need to buy a DNS domain, if you don't already have one, and set the Name Server to use Azure DNS.  If you go with an off-brand TLD like .xyz, you should be able to pick up a domain name for about $0.99 for the first year.  Azure DNS is about $.50 per zone per month and $0.40 per million queries.  All in, you're looking at about $2 for a DNS zone.

When you complete an exercise in the course, be sure to tear down the infrastructure.  Each exercise file ends with `terraform destroy`.  Just run that command and approve the destruction to remove all resources from AWS.

## Certification

HashiCorp has released the Terraform Certified Associate certification..  You might be wondering if this course fully prepares you for the cert.  **It does not.**  Taking this course along with the [Deep Dive - Terraform](https://app.pluralsight.com/library/courses/deep-dive-terraform) course on Pluralsight will meet most of the learning objectives for the certification, but there is no substitute for running the software on your own and hacking away.

I have coauthored a certification guide which you can find on [Leanpub](https://leanpub.com/terraform-certified/). This is an unofficial guide, but I believe in concert with the Pluralsight courses you will be in a good position to sit the exam.

## Conclusion

I hope you enjoy taking this course as much as I did creating it.  I'd love to hear feedback and suggestions for revisions.

Thanks and happy automating!

Ned