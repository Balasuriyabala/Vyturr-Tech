resource "aws_dlm_lifecycle_policy" "ebs_snapshot" {
  description        = "EBS Snapshot Policy"
  execution_role_arn = var.dlm_role_arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    target_tags = {
      Snapshot = "true"
    }

    schedule {
      name = "daily-backup"

      create_rule {
        interval      = 24
        interval_unit = "HOURS"
      }

      retain_rule {
        count = var.retention_count
      }

      copy_tags = true

      tags_to_add = {
        CreatedBy = "Terraform"
      }
    }
  }
}