

module "vpc" {
  source             = "../../VPC-module"
  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
}


module "eks-cluster" {
  source       = "../../EKS-module"
  project_name = var.project_name

  # aws auth
  administrator_role_name    = var.administrator_role_name
  terraform_role_name        = var.terraform_role_name
  # cicd_role_name             = var.cicd_role_name

  # eks
  cluster_version  = var.cluster_version
  subnet_ids       = module.vpc.private_subnet_ids
  vpc_id           = module.vpc.vpc_id
  k8s_service_cidr = var.k8s_service_cidr

  # worker
  instance_type    = var.instance_type
  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity
}