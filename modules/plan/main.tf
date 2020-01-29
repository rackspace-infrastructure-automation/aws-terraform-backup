/**
 * # aws-terraform-backup / plan
 *
 * This module creates an AWS Backup plan used to schedule backups and manage lifecycle of recovery points.
 *
 * ```HCL
 * module "backup_plan" {
 *   source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/plan/?ref=v0.12.0"
 *
 *   lifecycle = {
 *     delete_after = 35
 *   }
 *
 *   lifecycle_enable  = true
 *   plan_name         = "${local.tags["Environment"]}-Plan"
 *   rule_name         = "Daily"
 *   schedule          = "cron(0 5 ? * * *)"
 *   start_window      = 60
 *   tags              = "${local.tags}"
 *   target_vault_name = "${module.backup_vault.vault_name}"
 * }
 * ```
 *
 * Due to previous bugs [8431](https://github.com/terraform-providers/terraform-provider-aws/issues/8431) and [8737](https://github.com/terraform-providers/terraform-provider-aws/issues/8737)
 * we need to set the minimum aws provider version at 2.34.0
 */

terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.34.0"
  }
}

resource "aws_backup_plan" "backup_plan" {
  count = var.lifecycle_enable ? 0 : 1

  name = var.plan_name

  rule {
    rule_name           = var.rule_name
    target_vault_name   = var.target_vault_name
    schedule            = var.schedule
    start_window        = var.start_window
    completion_window   = var.completion_window
    recovery_point_tags = var.recovery_point_tags
  }

  tags = var.tags
}

resource "aws_backup_plan" "backup_plan_lifecycle" {
  count = var.lifecycle_enable ? 1 : 0

  name = var.plan_name

  rule {
    rule_name         = var.rule_name
    target_vault_name = var.target_vault_name

    dynamic "lifecycle" {
      for_each = [var.lifecycle]
      content {
        cold_storage_after = lookup(lifecycle.value, "cold_storage_after", null)
        delete_after       = lookup(lifecycle.value, "delete_after", null)
      }
    }

    schedule            = var.schedule
    start_window        = var.start_window
    completion_window   = var.completion_window
    recovery_point_tags = var.recovery_point_tags
  }

  tags = var.tags
}
