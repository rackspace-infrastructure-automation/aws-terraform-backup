provider "aws" {
  version = "~> 2.34"
  region  = "us-west-2"
}

module "backup_plan" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/plan/?ref=v0.12.0"

  completion_window = "300"

  lifecycle = {
    cold_storage_after = 30
    delete_after       = 120
  }

  lifecycle_enable = true
  plan_name        = "newPlan"

  recovery_point_tags = {
    BackupRule  = "Daily"
    BackupVault = "ExistingVaultName"
  }

  rule_name    = "newRule"
  schedule     = "cron(2 15 ? * * *)"
  start_window = "60"

  tags = {
    tag_key   = "tag_value"
    tag_key_2 = "tag_value_2"
  }

  target_vault_name = "ExistingVaultName"
}
