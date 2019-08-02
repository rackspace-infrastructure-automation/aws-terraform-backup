provider "aws" {
  version = "~> 2.14"
  region  = "us-west-2"
}

locals {
  tags = {
    Environment = "Test"
  }

  plan_name = "${local.tags["Environment"]}-Plan"
}

module "backup" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/backup/?ref=v0.0.3"

  environment = "${local.tags["Environment"]}"

  lifecycle = {
    delete_after = 35
  }

  lifecycle_enable = true
  plan_name        = "${local.plan_name}"
  plan_tags        = "${local.tags}"
  rule_name        = "Daily"
  schedule         = "cron(0 5 ? * * *)"
  selection_name   = "fullSelectionName"

  selection_tag = [
    {
      type  = "STRINGEQUALS"
      key   = "BackupPlan"
      value = "${local.plan_name}"
    },
  ]

  start_window = 60
  vault_name   = "${local.tags["Environment"]}-Vault"
  vault_tags   = "${local.tags}"
}
