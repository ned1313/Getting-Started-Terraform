 ## API_Gateway & Cloudwatch

These templates implements a api_gateway, cloudwatch alarm, dashboard and route53 health check, and associated necessary steps required. We used below services :

- API_Gateway
- cloudwatch_dashboard for api
- route53 health check

-- Mention your region, secret and access keys, vpc_id required in the templates.

To run these templates, clone the repository and run terraform apply within its own directory.

For example:

```tf
$ git clone https://github.com/ned1313/Getting-Started-Terraform
$ cd Getting-Started-Terraform/m9/api_gateway & Cloudwatch
$ terraform apply
```
