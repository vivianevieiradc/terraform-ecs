variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "container_image" {
  description = "Container image"
  type        = string
}

variable "container_port" {
  description = "Container exposed port"
  type        = number
}

variable "container_name" {
  description = "Container name to use in the task definition"
  type        = string
  default     = "nginx"
}


variable "desired_count" {
  description = "Desired ECS tasks"
  type        = number
}


variable "execution_role_arn" {
  description = "ARN da role de execução do ECS Task (IAM)"
  type        = string
}
