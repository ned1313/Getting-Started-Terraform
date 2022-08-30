billing_code = "ACCT8675309"
project      = "web-app"

vpc_cidr_block = {
  Development = "10.0.0.0/16",
  UAT         = "10.1.0.0/16",
  Production  = "10.2.0.0/16"
}

vpc_subnet_count = {
  Development = 2,
  UAT         = 2,
  Production  = 4
}

aws_instance_type = {
  Development = "t2.micro"
  UAT         = "t2.small"
  Production  = "t2.large"
}

aws_instance_count = {
  Development = 2,
  UAT         = 4,
  Production  = 6
}