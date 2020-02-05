provider "aws" {
  version = "~> 2.34"
  region  = "us-west-2"
}

locals {
  tags = {
    Environment = "Test"
  }

  plan_name = "${local.tags["Environment"]}-Plan"
}

module "backup" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/backup/?ref=v0.12.0"

  environment = local.tags["Environment"]

  lifecycle_bu = {
    delete_after = 35
  }

  lifecycle_enable = true
  plan_name        = local.plan_name
  plan_tags        = local.tags
  rule_name        = "Daily"
  schedule         = "cron(0 5 ? * * *)"
  selection_name   = "fullSelectionName"

  selection_tag = [
    {
      type  = "STRINGEQUALS"
      key   = "BackupPlan"
      value = local.plan_name
    },
  ]

  start_window = 60
  vault_name   = "${local.tags["Environment"]}-Vault"
  vault_tags   = local.tags
}
