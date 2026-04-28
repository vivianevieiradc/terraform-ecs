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
