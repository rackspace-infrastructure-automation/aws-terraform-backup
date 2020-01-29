/**
 * # aws-terraform-backup / selection
 *
 * This module creates an AWS Backup selection used to target resources for backup.
 *
 * ```HCL
 * module "backup_selection" {
 *   source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/selection/?ref=v0.0.3"
 *
 *   plan_id        = "${module.plan.plan_id}"
 *   resources      = []
 *   selection_name = "Tagged"
 *   selection_tag = [
 *     {
 *       type  = "STRINGEQUALS"
 *       key   = "BackupPlan"
 *       value = "${module.plan.plan_name}"
 *     },
 *   ]
 * }
 * ```
 *
 * [Further examples available.](./examples)
 */

data "aws_caller_identity" "current" {
}

locals {
  default_role = var.iam_role_arn != "" ? var.iam_role_arn : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/service-role/AWSBackupDefaultServiceRole"
}

module "backup_role" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role/?ref=v0.0.1"

  aws_service       = ["backup.amazonaws.com"]
  build_state       = var.create_iam_role
  name              = var.iam_role_name
  policy_arns       = ["arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"]
  policy_arns_count = 1
}

resource "aws_backup_selection" "backup_selection" {
  iam_role_arn = var.create_iam_role ? module.backup_role.arn : local.default_role
  name         = var.selection_name
  plan_id      = var.plan_id

  dynamic "selection_tag" {
    for_each = var.selection_tag
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      key   = selection_tag.value.key
      type  = selection_tag.value.type
      value = selection_tag.value.value
    }
  }

  resources = var.resources
}

