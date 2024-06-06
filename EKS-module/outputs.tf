output "eks_cluster_worker_nodes_security_group_id" {
  value = aws_security_group.eks_nodes_sg.id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_ca_certificate" {
  description = "CA certificate of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "eks_cluster_token" {
  description = "The token for API access to the EKS cluster"
  value       = data.aws_eks_cluster_auth.cluster.token
}