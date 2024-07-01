
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.project_name}-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.cluster_version


  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"] # Restrict to specific CIDR ranges
    subnet_ids              = var.subnet_ids #private
    security_group_ids      = [aws_security_group.eks_sg.id]
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.k8s_service_cidr
  }

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = aws_kms_key.eks_kms_key.arn
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_policy_attachment,
    aws_iam_role_policy_attachment.worker_policy_attachment,
  ]
}

resource "aws_security_group" "eks_sg" {
  name   = "${var.project_name}-eks-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_ec2_tag" "eks_sg_tag" {
  resource_id = aws_security_group.eks_sg.id
  key         = "kubernetes.io/cluster/${var.project_name}-eks-cluster"
  value       = "owned"
}


resource "aws_security_group_rule" "eks_sg_to_eks_nodes_sg_ingress" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_sg.id
  source_security_group_id = aws_security_group.eks_nodes_sg.id
}

