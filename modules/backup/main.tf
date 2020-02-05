/*
* # aws-terraform-backup / backup
* This module creates an entire AWS Backup configuration with a vault, plan, selection and optional IAM Role
* Due to previous bugs [8431](https://github.com/terraform-providers/terraform-provider-aws/issues/8431) and [8737](https://github.com/terraform-providers/terraform-provider-aws/issues/8737)
* we need to set the minimum aws provider version at 2.34.0
*
* ## Basic Example
* ```HCL
* module "backup" {
*   source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/backup/?ref=v0.12.0"
*
*   iam_role_name = "newRolename"
*   plan_name = "newPlanName"
*
*   resources = [
*     #Dynamo
*     "arn:aws:dynamodb:us-west-2:<account>:table/<table_name>",
*
*     # EFS
*     "arn:aws:elasticfilesystem:us-west-2:<account>:file-system/fs-c9f44862",
*
*     # EBS
*     "arn:aws:ec2:us-west-2:<account>:volume/vol-0589bb15c1d311dfa",
*   ]
*
*   rule_name = "newRuleName"
*   selection_name = "fullSelectionName"
*
*   selection_tag = [
*     {
*       type  = "STRINGEQUALS"
*       key   = "backup_it"
*       value = "all"
*     },
*   ]
*   vault_name = "newVault"
* }
* ```
*
* [Further examples available.](./examples)
*
* ## Terraform 0.12 upgrade
*
* Changes were required while adding terraform 0.12 compatibility.
*
* ### Module variables
*
* The following module variable was updated due to requirements for a reserved name:
*
* - `lifecycle` -> `lifecycle_bu`
*/

terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.34.0"
  }
}

locals {
  tags = {
    Environment     = var.environment
    ServiceProvider = "Rackspace"
  }

  plan_tags = merge(local.tags, var.plan_tags)

  vault_tags = merge(local.tags, var.vault_tags)
}

module "plan" {
  source = "../plan"

  completion_window   = var.completion_window
  lifecycle_bu        = var.lifecycle_bu
  lifecycle_enable    = var.lifecycle_enable
  plan_name           = var.plan_name
  recovery_point_tags = var.recovery_point_tags
  rule_name           = var.rule_name
  schedule            = var.schedule
  start_window        = var.start_window
  tags                = local.plan_tags
  target_vault_name   = module.vault.vault_name
}

module "selection" {
  source = "../selection"

  iam_role_arn   = var.iam_role_arn
  iam_role_name  = var.iam_role_name
  plan_id        = module.plan.plan_id
  resources      = var.resources
  selection_name = var.selection_name
  selection_tag  = var.selection_tag

}

module "vault" {
  source = "../vault"

  kms_key_arn = var.kms_key_arn
  tags        = local.vault_tags
  vault_name  = var.vault_name
}
