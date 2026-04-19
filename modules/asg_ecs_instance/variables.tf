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
