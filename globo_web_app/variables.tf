
variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources"
  default     = "globoweb"
}

variable "aws_regions" {
  type        = list(string)
  description = "Regions to use for AWS resources"
  #called via var.aws_regions[0]
  default = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"]
}

variable "aws_region" {
  type        = string
  description = "Region to use for AWS resources"
  default     = "us-east-1"
}

variable "aws_cidr_block" {
  type        = list(string)
  description = "Simplifying cidr_block"
  default     = ["10.0.0.0/24", "10.0.1.0/24", "0.0.0.0/0", "10.0.0.0/16"]

}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  default     = true
}


variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map a public IP address for Subnet instances"
  default     = true
}


variable "vpc_cidr_block" {
  type        = map(string)
  description = "Simplifying cidr_block"
}

variable "vpc_subnet_count" {
  type        = map(number)
  description = "Number of subnets to create"

}

variable "aws_instance_count" {
  type        = map(number)
  description = "Number of instance to create"
}

variable "aws_instance_type" {
  type        = map(string)
  description = "Type for EC2 Instance"
}

variable "company" {
  type        = string
  description = "Company name"
  default     = "Globomantics"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "billing_code" {
  type        = string
  description = "Project name"
}