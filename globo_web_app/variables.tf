
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

variable "vpc_cidr_block" {
  type        = string
  description = "Simplifying cidr_block"
  default     = "10.0.0.0/16"

}

variable "vpc_subnet_count" {
  type        = number
  description = "Number of subnets to create"
  default     = 2
}

variable "aws_instance_count" {
  type        = number
  description = "Number of instance to create"
  default     = 2
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  default     = true
}

#variable "billing-log" {}



variable "aws_instance_sizes" {
  type        = map(string)
  description = "Regions to use for AWS resources"
  default = {
    small  = "t2.micro"
    medium = "t2.small"
    large  = "t2.large"
  }
  sensitive = false
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