
resource "aws_kms_key" "eks_kms_key" {
  description             = "KMS key for EKS secrets encryption"
  deletion_window_in_days = 30

  tags = {
    Name = "eks-secrets-kms-key"
  }
}

resource "aws_kms_alias" "eks_kms_alias" {
  name          = "alias/eks-secrets-kms-key"
  target_key_id = aws_kms_key.eks_kms_key.id
}