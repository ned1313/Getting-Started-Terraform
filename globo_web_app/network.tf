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
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  cidr = var.vpc_cidr_block

  azs             = slice(data.aws_availability_zones.names,0,(var.vpc_subnet_count))
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


resource "aws_vpc" "vpc" {
  cidr_block           = var.aws_cidr_block[3]
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(local.common_tags, {
    Name  = "${local.name_prefix}-vpc"
  })

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tags, {
    Name  = "${local.name_prefix}-igw"
  })
}


resource "aws_subnet" "subnets" {
  count                   = var.vpc_subnet_count
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(local.common_tags, {
      Name  = "${local.name_prefix}-subnet${count.index}"
    })

}

# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.aws_cidr_block[2]
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
      Name  = "${local.name_prefix}-rtb"
    })
}

resource "aws_route_table_association" "rta-subnets" {
  count          = var.vpc_subnet_count
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rtb.id
}

# SECURITY GROUPS #

# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name   = "nginx_alb_sg"
  vpc_id = aws_vpc.vpc.id

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
      Name  = "${local.name_prefix}-alb_sg"
    })

}

# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "nginx_sg"
  vpc_id = aws_vpc.vpc.id

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
      Name  = "${local.name_prefix}-nginx-sg"
    })

}





