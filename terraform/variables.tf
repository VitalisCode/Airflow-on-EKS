variable "aws_region" {
  type = string
}

variable "profile" {
  type        = string
  description = "AWS profile to be used."
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "node_instance_types" {
  type = list(string)
}

variable "desired_nodes" {
  type = number
}

variable "min_nodes" {
  type = number
}

variable "max_nodes" {
  type = number
}

variable "database_name" {
  type = string
}

variable "database_user" {
  type      = string
  sensitive = true
}

variable "database_password" {
  type        = string
  description = "Optional override for the database password. If not set, a random password is generated and stored in AWS Secrets Manager."
  sensitive   = true
  default     = null
  nullable    = true
}

variable "database_secret_name" {
  type        = string
  description = "Name of the Secrets Manager secret that stores the database password. Defaults to <cluster_name>-database-password."
  default     = null
  nullable    = true
}

variable "rds_instance_class" {
  type = string
}

variable "rds_allocated_storage" {
  type = number
}
