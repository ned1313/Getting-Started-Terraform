# Getting-Started-Terraform

Welcome to Terraform - Getting Started.  These exercise files are meant to accompany my course on [Pluralsight](http://www.pluralsight.com/courses/terraform-getting-started-2023).  The course was developed using version 1.4.2 of Terraform. Since the GA of version 1.0, HashiCorp has committed to no breaking changes until version 2.0. All the exercises in this course should be valid as long as you are using Terraform in the 1.X version family. The modules and providers in this course have no such guarantee, so I have pinned the version where applicable.

If you're looking for the exercise files for older versions of the course, there are two branches to check out:

* [v3](https://github.com/ned1313/Getting-Started-Terraform/tree/v3) - Corresponding to the [course published on Novemeber 2, 2021](https://app.pluralsight.com/library/courses/terraform-getting-started-2021/table-of-contents).
* [pre-1.0] - Corresponding to the [course published on October 1, 2019](https://app.pluralsight.com/library/courses/getting-started-terraform/table-of-contents).

I don't recommend taking the older courses, as they are out of date and do not cover the latest features of Terraform.  I have left the branches available since you may be assigned an older course by your employer.

## Using the files

In the course, you are given a Terraform configuration for a basic web application from someone else on the Globomantics team. We are going to make a copy of this configuration and modify it over the length of the course. The `base_web_app` directory has the basic web app configuration, which we will copy over to a new directory called `globo_web_app`, and start making alterations.

As we progress through the modules, you will be challenged to make updates to the files in `globo_web_app` to meet the evolving needs and requirements of the web application infrastructure. The completed solution for each module is in the `mX_solution` directories. I recommend trying to first write the solution yourself, and then checking your answer against what you see in the solution file.

At the beginning of module three, we will hardcode our AWS keys into the configuration. **You should not do this in any real world scenario!** I am trying to illustrate a point in the course. *Please do not commit your AWS keys to source control*. Some of us (**me**) have done this in the past and felt very silly. We will move these keys into environment variables in module four, and they shall never again be hardcoded **anywhere**.

The suggested commands for each module are in the `commands` directory. You can run these commands to get through the exercises, but I also encourage you to experiment and try things out for yourself.

## Providers

This course uses the AWS and Random providers. At the start of the course, we are not specifying a particular version of the AWS provider, meaning Terraform will grab the latest version. The **day** after I finished the course, version `5.0` of the AWS provider was released 😔. So while you will see version `4.X` in the course video, when you initialize your configuration for the first time, you will get version `5.X`. They are no breaking changes in the AWS provider between `4.X` and `5.X` that impact the example code, so it *should* all work as expected, with one minor exception.

In module 6, we add the Random provider and specify required versions for both providers, setting the AWS provider to use major version 4. In the videos, I am already using major version 4, so Terraform didn't have a problem with adding the version constraint and running `terraform init`. However, you will be using major version 5 of the provider, and the addition of the version constraint will mean Terraform has to download a different version of the provider and update the lock file. When you run `terraform init`, you will get an error message indicating that your version constraints have changed and you need to run `terraform init -upgrade` to update the lock file. You can safely run this command and everything will work as expected.

I admit the `-upgrade` switch is a little misleading, as it implies that you are moving to a newer version of the provider, when in reality you're moving down a major version. I wish the command was something else, like `terraform init -update` or something. But alas, it is what it is.

## AWS Environment

You will need access to an AWS environment with permissions to create resources in EC2, S3, and IAM. I recommend creating a dedicated account just for this course. The exercises have been tested with AWS region `us-east-1`. The input variable `aws_region` has `us-east-1` set as the default, but you can supply a different region if you prefer. Generally, the exercises should work in any region that has at least three availability zones and an Amazon Linux 2 AMI.

You will need to generate an AWS access key to run through the exercises. You can do this through the IAM console in a browser (*hint*: it's under security credentials for your user) by following the [official AWS docs](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/). I'd recommend assigning the `AdministratorAccess` policy to your user to give you permissions to do everything in the account. Also, enable 2FA for the user account!

## Line Endings

An issue I have discovered from time to time is that Terraform doesn't much like the Windows style of ending a line with both a Carriage Return (CR) and a Line Feed (LF), commonly referred to as CRLF.  If you are experiencing strange parsing issues, change the line ending to be Line Feed (LF) only.  In VS Code this can be down by clicking on the CRLF in the lower right corner and changing it to LF. This primarily affects template files or scripts being sent to a Linux machine for processing.

## MONEY!!!

A gentle reminder about cost.  The course will have you creating resources in AWS.  Some of the resources are not going to be 100% free.  I have tried to use the [Free-tier](https://aws.amazon.com/free/) when possible, but you many still incur some charges.

When you complete an exercise in the course, you can easily tear down the deployed infrastructure using `terraform destroy`. Just run that command and approve the destruction to remove all resources from AWS. Before you start the next module, run `terraform apply` again and you should be right where you started. Isn't infrastructure automation amazing?!

## Certification

HashiCorp has released the Terraform Certified Associate certification. You might be wondering if this course fully prepares you for the cert.  **It does not.**  Taking this course along with the [Deep Dive - Terraform](https://app.pluralsight.com/library/courses/terraform-deep-dive) course on Pluralsight will meet most of the learning objectives for the certification, but there is no substitute for running the software on your own and hacking away.

I have coauthored a certification guide which you can find on [Leanpub](https://leanpub.com/terraform-certified/). This is an unofficial guide, but I believe in concert with the Pluralsight courses you will be in a good position to sit the exam. And in case you're wondering, yes it is fully updated for version 003 of the exam that was released in May 2023.

## Conclusion

I hope you enjoy taking this course as much as I did creating it.  I'd love to hear feedback and suggestions for revisions. Find me on Twitter (@ned1313) or add an issue to this repository.

Thanks and happy automating!

Ned
