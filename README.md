# Getting-Started-Terraform

Welcome to Terraform - Getting Started.  These exercise files are meant to accompany my course on [Pluralsight](https://app.pluralsight.com/library/courses/terraform-getting-started).  The course was developed using version 0.9 of Terraform, which is like *forever* ago in the world of software development.  I have since updated the exercises based on the 0.11 version of Terraform.  If you have moved to 0.12 then some of these exercises may not work for you.  There are a **ton** of changes in version 0.12 and it will require revamping the course, as well as the exercise files.  

## Using the files
Each folder represents a module from the course and is completely self contained.  In each module there will be an example of the *tfvars* file that you will use named *terraform.tfvars.example*.  Simply update the contents of the file and rename it *terraform.tfvars*.  Due to the sensitive nature of the information you place in the *tfvars* file, **do not** check it into source control, especially a public repository.  Some of us - *read me* - have made that mistake before and had to delete AWS access keys post-haste.

Once you have updated and renamed the *tfvars* file(s), you can run the commands in the *m#_commands.txt* file, where the *#* is the number of the module.  Be sure to run the commands from the working directory of the module.  Or you can just noodle around on the terraform CLI and see what you can discover/break.  If you run into an issue, please submit it as such and I will do my best to remediate it.

Thanks and happy automating!

Ned