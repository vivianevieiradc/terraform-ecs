output "vpc_id" {
  value = module.vpc.vpc_id
}

output "cluster_name" {
  value = module.cluster.cluster_name
}

output "service_name" {
  value = module.cluster.service_name
}
