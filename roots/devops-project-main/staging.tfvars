

project_name = "Project-Aurora"

#### VPC MODULE

vpc_cidr           = "10.0.0.0/16"
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
private_subnets    = ["10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]

#### EKS MODULE

# aws auth
administrator_role_name = "AWSReservedSSO_AdministratorAccessTEST_1f5c40c62436dfc4"
terraform_role_name     = "GitHubActionsTerraformIAMrole"
# cicd_role_name          = "GitHubActionsCICDrole"

# eks
cluster_version  = "1.27" -> "1.28"
k8s_service_cidr = "10.10.0.0/16"

# worker
instance_type    = "t3.medium"
desired_capacity = 2
max_size         = 5
min_size         = 1

