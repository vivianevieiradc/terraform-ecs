variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for EC2 instances"
  type        = list(string)
}

variable "ecs_cluster_name" {
  description = "ECS Cluster name"
  type        = string
}

variable "instance_profile_name" {
  description = "EC2 Instance Profile name (IAM)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "ASG min size"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "ASG max size"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "ASG desired capacity"
  type        = number
  default     = 1
}

variable "alb_security_group_id" {
  description = "ALB security group ID allowed to reach ECS dynamic host ports. Keep null for SSM-only workloads."
  type        = string
  default     = null
}

variable "dynamic_host_port_min" {
  description = "Minimum host port for ECS dynamic port mapping"
  type        = number
  default     = 32768
}

variable "dynamic_host_port_max" {
  description = "Maximum host port for ECS dynamic port mapping"
  type        = number
  default     = 65535
}
