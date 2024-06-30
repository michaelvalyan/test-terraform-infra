# IAM MODULE

# Define input variables for environment 
variable "env" {
  description = "Env for Dev and Prod"
  type        = string
  default     = "default"
}

# Define input variables for tag key
variable "final_project_tag" {
  description = "Value for the 'tag-key'"
  type        = string
  default     = "default_tag"
}


variable "project_name" {
  description = "The name of a project"
  type        = string
}

# VPC MODULE

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

# EKS MODULE

variable "administrator_role_name" {
  description = "The name of the IAM role for the administrator."
  type        = string
}

variable "terraform_role_name" {
  description = "The name of the IAM role for Terraform actions."
  type        = string
}

# variable "cicd_role_name" {
#   description = "The name of the IAM role for CI/CD actions."
#   type        = string
# }

variable "cluster_version" {
  description = "The desired Kubernetes version for the EKS cluster"
  type        = string
}

variable "k8s_service_cidr" {
  description = "The service IPv4 CIDR for the Kubernetes cluster"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EKS worker nodes"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances in the EKS worker nodes auto-scaling group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the EKS worker nodes auto-scaling group"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances in the EKS worker nodes auto-scaling group"
  type        = number
}