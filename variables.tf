variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS profile name (optional)"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "ecs-study"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "container_image" {
  description = "Container image"
  type        = string
  default     = "nginx:latest"
}

variable "container_port" {
  description = "Container exposed port"
  type        = number
  default     = 80
}


variable "desired_count" {
  description = "Desired ECS tasks"
  type        = number
  default     = 1
}
