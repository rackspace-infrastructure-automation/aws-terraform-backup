provider "aws" {
  version = "~> 2.14"
  region  = "us-west-2"
}

module "backup_plan" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/plan?ref=v0.0.1"

  # Required
  plan_name         = "newPlan"
  rule_name         = "newRule"
  target_vault_name = "ExistingVaultName"

  # Optional
  schedule          = "cron(2 15 * * ? *)"
  start_window      = "1"
  completion_window = "8"

  plan_tags = {
    tag_key   = "tag_value"
    tag_key_2 = "tag_value_2"
  }

  recovery_point_tags = {
    tag_name       = "yes"
    other_tag_name = "still_yes"
  }

  # To use cold storage lifecycle
  use_lifecycle = true

  lifecycle = {
    cold_storage_after = 10
    delete_after       = 100
  }
}
