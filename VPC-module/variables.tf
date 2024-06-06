
variable "greeting" {
  description = "A greeting phrase"
  default     = "Hello"
}


variable "project_name" {
  description = "The name of a project"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones in which to create subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
}

