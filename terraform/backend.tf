# terraform {
#   backend "s3" {
#     bucket         = "replace-with-your-terraform-state-bucket"
#     key            = "airflow-on-eks/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "replace-with-your-terraform-lock-table"
#     encrypt        = true
#   }
# }

