provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  host                   = module.eks-cluster.cluster_endpoint
  token                  = module.eks-cluster.eks_cluster_token
  cluster_ca_certificate = base64decode(module.eks-cluster.cluster_ca_certificate)
}

terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
