##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}
variable "region" {
  default = "us-west-2"
}

# CIDR for VPC
variable "network_address_space" {
  default = "10.1.0.0/16"
}

# CIDR for subnet 1
variable "subnet1_address_space" {
  default = "10.1.0.0/24"
}

# CIDR for subnet 2
variable "subnet2_address_space" {
  default = "10.1.1.0/24"
}
##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  secret_key = var.aws_secret_key
  access_key = var.aws_access_key  
  region     = var.region
}

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {}


data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


##################################################################################
# RESOURCES
##################################################################################

#This uses the default VPC.  It WILL NOT delete it on destroy.

#NETWORKING

# Creation of VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.network_address_space
  enable_dns_hostnames = "true"

}

# Creation of Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

}

# Creation of Subnet 1
resource "aws_subnet" "subnet1" {
  cidr_block              = var.subnet1_address_space
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]
}

# Creation of Subnet 2
resource "aws_subnet" "subnet2" {
  cidr_block              = var.subnet2_address_space
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[1]
}

# Creation of Route Table
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Creation relationship between Subnet 1 and RouteTable
resource "aws_route_table_association" "rta-subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rtb.id
}

# Creation relationship between Subnet 2 and RouteTable
resource "aws_route_table_association" "rta-subnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rtb.id
}

resource "aws_security_group" "elb-sg" {
  name        = "nginx-elb-sg"
  description = "Allow ports for nginx demo elb"
  vpc_id      = aws_vpc.vpc.id

  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  description = "Allow ports for nginx instance"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.network_address_space]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creation Load Balancer

resource "aws_elb" "elb_web"{
  name = "nginx-elb"
  subnets         = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  security_groups = [aws_security_group.elb-sg.id]
  instances       = [aws_instance.nginx1.id, aws_instance.nginx2.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

resource "aws_instance" "nginx1" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  subnet_id              = aws_subnet.subnet1.id
  user_data = "${file("userdatablue.txt")}"

  tags = {
    Name = "Devops Terraform Test Blue"
  }  
}

resource "aws_instance" "nginx2" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  subnet_id              = aws_subnet.subnet2.id
  user_data = "${file("userdatagreen.txt")}"

  tags = {
    Name = "Devops Terraform Test Green"
  }  
}

#################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
  value = aws_elb.elb_web.dns_name
}
