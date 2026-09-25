variable "release_name" {
  type = string
}

variable "namespace" {
  type    = string
  default = "airflow"
}

variable "chart_version" {
  type    = string
  default = "1.15.0"
}

variable "values_file" {
  type = string
}

variable "efs_file_system_id" {
  type = string
}

variable "efs_access_point_id" {
  type = string
}

variable "database_host" {
  type = string
}

variable "database_name" {
  type = string
}

variable "database_user" {
  type      = string
  sensitive = true
}

variable "database_password" {
  type      = string
  sensitive = true
}
