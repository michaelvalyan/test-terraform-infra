
data "aws_caller_identity" "current" {}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks_cluster.id
}

locals {
  account = data.aws_caller_identity.current.account_id
}

resource "kubernetes_config_map" "aws_auth" {
  depends_on = [aws_eks_cluster.eks_cluster]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        groups   = ["system:bootstrappers", "system:nodes"]
        rolearn  = aws_iam_role.eks_worker_role.arn
        username = "system:node:{{EC2PrivateDNSName}}"
      },
      {
        groups   = ["system:masters"]
        rolearn  = "arn:aws:iam::${local.account}:role/${var.administrator_role_name}"
        username = "${var.administrator_role_name}User"
      },
      {
        groups   = ["system:masters"]
        rolearn  = "arn:aws:iam::654654483613:role/mg-account-trust-role"
        username = "MyUser"
      }
      # {
      #   groups   = ["system:masters"]
      #   rolearn  = "arn:aws:iam::${local.account}:role/${var.terraform_role_name}"
      #   username = "${var.terraform_role_name}User"
      # },
      # {
      #   groups   = ["system:masters"]
      #   rolearn  = "arn:aws:iam::${local.account}:role/${var.cicd_role_name}"
      #   username = "${var.cicd_role_name}User"
      # }
    ])
  }
}

