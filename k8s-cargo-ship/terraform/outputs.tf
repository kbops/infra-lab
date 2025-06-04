output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.eks.cluster_certificate_authority_data
}

output "cargo_ship_ecr_repository_url" {
  description = "The URL of the ECR repository for k8s-cargo-ship"
  value       = data.aws_ecr_repository.k8s_cargo_ship.repository_url
}

output "region" {
  description = "The AWS region where the EKS cluster is deployed"
  value       = local.region
}
