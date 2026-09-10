output "vpc_id" {
  value = module.vpc.vpc_id
}

output "cluster_name" {
  value = module.cluster.cluster_name
}

output "service_name" {
  value = module.cluster.service_name
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "github_actions_role_arn" {
  description = "ARN to set as the AWS_ROLE_ARN GitHub Actions repository variable"
  value       = module.github_oidc.role_arn
}
