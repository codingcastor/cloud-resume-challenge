variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"  # Free tier is most widely available in us-east-1
}

variable "project_name" {
  description = "Project name to be used for resource naming"
  type        = string
  default     = "cloud-resume"
}

variable "environment" {
  description = "Environment (dev/prod)"
  type        = string
  default     = "dev"
}

variable "domain_name" {
  description = "Domain name for the website"
  type        = string
}
