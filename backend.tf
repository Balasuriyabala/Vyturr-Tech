# S3 bucket for Terraform state (must be created before first `terraform init`)
//resource "aws_s3_bucket" "terraform_state" {
//  bucket = "vyturr-terraform-state-prod"

//  lifecycle {
//    prevent_destroy = true
//  }
//}