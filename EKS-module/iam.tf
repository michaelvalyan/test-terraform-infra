# EKS CLUSTER IAM

resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
  for_each   = toset(var.eks_role_policy_arns)
  policy_arn = each.value
  role       = aws_iam_role.eks_cluster_role.name
}


# WORKER NODES AIM

resource "aws_iam_role" "eks_worker_role" {
  name = "${var.project_name}-eks-worker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "eks_worker_instance_profile" {
  name = "${var.project_name}-eks-worker-instance-profile"
  role = aws_iam_role.eks_worker_role.name
}

resource "aws_iam_role_policy_attachment" "worker_policy_attachment" {
  for_each   = toset(var.worker_role_policy_arns)
  policy_arn = each.value
  role       = aws_iam_role.eks_worker_role.name
}

data "tls_certificate" "eks" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer

  tags = {
    "kubernetes.io/cluster/${aws_eks_cluster.eks_cluster.name}" = "owned"
  }
}