provider "aws" {
  version = "~> 2.14"
  region  = "us-west-2"
}

module "backup_plan" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/plan/?ref=v0.0.3"

  plan_name    = "newPlan"
  rule_name    = "newRule"
  schedule     = "cron(0 5 ? * * *)"
  start_window = "60"

  tags = {
    tag_key   = "tag_value"
    tag_key_2 = "tag_value_2"
  }

  target_vault_name = "ExistingVaultName"
}

