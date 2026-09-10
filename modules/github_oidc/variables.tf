variable "github_repo" {
  description = "GitHub repo allowed to assume this role, in \"owner/repo\" format"
  type        = string
}

variable "role_name" {
  description = "Name of the IAM role assumed by GitHub Actions"
  type        = string
  default     = "github-actions-terraform-ecs"
}
