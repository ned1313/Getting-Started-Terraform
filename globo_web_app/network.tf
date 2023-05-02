data "aws_availability_zones" "available" {
  state = "available"
}

# NETWORKING #
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = local.common_tags
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = local.common_tags
}
/*
resource "aws_subnet" "subnet-a" {
  cidr_block              = var.vpc_subnets_cidr_block[0]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = local.common_tags
}
resource "aws_subnet" "subnet-b" {
  cidr_block              = var.vpc_subnets_cidr_block[1]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = local.common_tags
}
resource "aws_subnet" "subnet-c" {
  cidr_block              = var.vpc_subnets_cidr_block[2]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = local.common_tags
}
*/

resource "aws_subnet" "subnets" {
  count = length(var.vpc_subnets_cidr_block)
  cidr_block              = var.vpc_subnets_cidr_block[count.index]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags                    = local.common_tags
}

# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = local.common_tags
}

resource "aws_route_table_association" "rta-subnets" {
  count          = length(var.vpc_subnets_cidr_block)
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rtb.id
}

# SECURITY GROUPS #
# Loadbalancer security group 
resource "aws_security_group" "alb_sg" {
  name   = "nginx_alb_sg"
  vpc_id = aws_vpc.vpc.id
  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #alb allows port 80 access from anywhere
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

# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "nginx_sg"
  vpc_id = aws_vpc.vpc.id

  # HTTP access from VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block] #should now only accept traffic from addresses within the vpc
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
