# Getting-Started-Terraform

Welcome to Terraform - Getting Started.  These exercise files are meant to accompany my course on [Pluralsight](https://app.pluralsight.com/library/courses/terraform-getting-started).  The course was developed using version 1.0.8 of Terraform. Since the GA of version 1.0, HashiCorp has committed to no breaking changes until version 2.0. All the exercises in this course should be valid as long as you are using Terraform in the 1.X version family. The modules and providers in this course have no such guarantee, so I have pinned the version where applicable.

This version of the course is **significantly** different from the previous version. If you're looking for the exercise files for the older course, they are available on the `pre-1.0` branch of this repository. Those files should work with version 0.14.3 of Terraform, but no guarantees on anything newer.

## Using the files

In the course, you are given a Terraform configuration for a basic web application from someone else on the Globomantics team. We are going to make a copy of this configuration and modify it over the length of the course. The `base_web_app` directory has the basic web app configuration, which we will copy over to the `globo_web_app` and start making alterations.

As we progress through the modules, you will be challenged to make updates to the files in `globo_web_app` to meet the evolving needs and requirements of the web application infrastructure. The completed solution for each module is in the `mX_solution` directories. I recommend trying to first write the solution yourself, and then checking your answer against what you see in the solution file.

At the beginning of module three, we will hardcode our AWS keys into the configuration. **You would not do this in any kind of scenario!** I am trying to illustrate a point in the course. *Please do not commit your AWS keys to source control*. Some of us (**me**) have done this in the past and felt very silly. We will move these keys into environment variables in module four, and they shall never again be hardcoded **anywhere**.

The suggested commands for each module are in the `commands` directory. You can run these commands to get through the exercises, but I also encourage you to experiment and try things out for yourself.

## AWS Environment

You will need access to an AWS environment with permissions to create resources in EC2, S3, and IAM. I recommend creating a throwaway account just for this course. The exercises have been tested with AWS region `us-east-1`. The input variable `aws_region` has `us-east-1` set as the default, but you can supply a different region if you prefer. Generally, the exercises should work in any region that has at least three availability zones and an Amazon Linux 2 AMI.

You will need to generate an AWS access key to run through the exercises. You can do this through the IAM console in a browser (*hint*: it's under security credentials for your user) by following the [official AWS docs](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/). I'd recommend assigning the `AdministratorAccess` policy to your user to give you permissions to do everything in the account. Also, enable 2FA for the user account!

## Line Endings

An issue I have discovered from time to time is that Terraform doesn't much like the Windows style of ending a line with both a Carriage Return (CR) and a Line Feed (LF), commonly referred to as CRLF.  If you are experiencing strange parsing issues, change the line ending to be Line Feed (LF) only.  In VS Code this can be down by clicking on the CRLF in the lower right corner and changing it to LF. This primarily affects template files or scripts being sent to a Linux machine for processing.

## MONEY!!!

A gentle reminder about cost.  The course will have you creating resources in AWS.  Some of the resources are not going to be 100% free.  I have tried to use the [Free-tier](https://aws.amazon.com/free/) when possible, but in some cases I have elected to use a larger size EC2 instance to demonstrate the possibilities with multiple environments.  

When you complete an exercise in the course, you can easily tear down the deployed infrastructure using `terraform destroy`. Just run that command and approve the destruction to remove all resources from AWS. Before you start the next module, run `terraform apply` again and you should be right where you started. Isn't infrastructure automation amazing?!

## Certification

HashiCorp has released the Terraform Certified Associate certification. You might be wondering if this course fully prepares you for the cert.  **It does not.**  Taking this course along with the [Deep Dive - Terraform](https://app.pluralsight.com/library/courses/deep-dive-terraform) course on Pluralsight will meet most of the learning objectives for the certification, but there is no substitute for running the software on your own and hacking away.

I have coauthored a certification guide which you can find on [Leanpub](https://leanpub.com/terraform-certified/). This is an unofficial guide, but I believe in concert with the Pluralsight courses you will be in a good position to sit the exam.

## Conclusion

I hope you enjoy taking this course as much as I did creating it.  I'd love to hear feedback and suggestions for revisions. Find me on Twitter (@ned1313) or add an issue to this repository.

Thanks and happy automating!

Ned