##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
module "app" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  cidr = var.vpc_cidr_block

  azs = slice(data.aws_availability_zones.available.names, 0, var.vpc_public_subnet_count)
  # Assumes 8 bits to be added to the CIDR range for the VPC
  public_subnets = [for subnet in range(var.vpc_public_subnet_count) : cidrsubnet(var.vpc_cidr_block, 8, subnet)]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  map_public_ip_on_launch = var.map_public_ip_on_launch
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-vpc"
  })
}

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx_sg" {
  name   = "${local.naming_prefix}-nginx_sg"
  vpc_id = module.app.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_security_group" "alb_sg" {
  name   = "${local.naming_prefix}-nginx_alb_sg"
  vpc_id = module.app.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

