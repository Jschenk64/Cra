variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.150.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.150.1.0/24", "10.150.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.150.3.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "instance_ami" {
  description = "AMI ID for instances"
  type        = string
  default     = "ami-08ec94f928cf25a9d"
}

variable "instance_type" {
  description = "Type of instance to deploy"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for instances"
  type        = string
  default     = "mse-svh105"
}

variable "security_group_id" {
  description = "Security group ID for instances"
  type        = string
  default     = "sg-087bbf47a2d760634"
}

variable "load_balancer_names" {
  description = "Names for load balancers"
  type        = list(string)
  default     = ["CRA-LB1", "CRA-LB2"]
}

variable "target_group_names" {
  description = "Names for target groups"
  type        = list(string)
  default     = ["CRA-Target1", "CRA-Target2"]
}
