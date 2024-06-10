# resource "aws_eks_addon" "csi_driver" {
#   cluster_name             = aws_eks_cluster.eks_cluster.name
#   addon_name               = "aws-ebs-csi-driver"
#   addon_version            = "v1.27.0-eksbuild.1"
#   service_account_role_arn = aws_iam_role.eks_ebs_csi_driver.arn
# }

# resource "aws_eks_addon" "vpc_cni" {
#   cluster_name  = aws_eks_cluster.eks_cluster.name
#   addon_name    = "vpc-cni"
#   addon_version = "v1.16.2-eksbuild.1"
# }
