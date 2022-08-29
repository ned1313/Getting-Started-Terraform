##################################################################################
# DATA
##################################################################################
# now we go to our resources and set variables for avaliability zone
data "aws_availability_zones" "available" {}

#Referred to by var.aws_region
#E.g., I want the description. var.aws_region.description

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  cidr = var.vpc_cidr_block

  azs            = slice(data.aws_availability_zones.available.names, 0, (var.vpc_subnet_count))
  public_subnets = [for subnet in range(var.vpc_subnet_count) : cidrsubnet(var.vpc_cidr_block, 8, subnet)]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })

}
# SECURITY GROUPS #

# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name   = "nginx_alb_sg"
  vpc_id = module.vpc.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.aws_cidr_block[2]]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.aws_cidr_block[2]]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-alb_sg"
  })

}

# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "nginx_sg"
  vpc_id = module.vpc.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.aws_cidr_block[3]]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.aws_cidr_block[2]]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-nginx-sg"
  })

}





