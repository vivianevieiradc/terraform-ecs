module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}
module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
}

module "asg_ecs_instance" {
  source                = "./modules/asg_ecs_instance"
  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.public_subnet_ids
  ecs_cluster_name      = module.cluster.cluster_name
  instance_profile_name = module.iam.ecs_instance_profile_name
  # instance_type, min_size, max_size, desired_capacity usam default, pode sobrescrever via tfvars
}

module "cluster" {
  source             = "./modules/cluster"
  project_name       = var.project_name
  aws_region         = var.aws_region
  container_image    = var.container_image
  container_port     = var.container_port
  desired_count      = var.desired_count
  execution_role_arn = module.iam.ecs_task_execution_role_arn
}
