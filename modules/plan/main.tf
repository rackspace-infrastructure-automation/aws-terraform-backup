// Currently a bug in updating plans with lifecycles. Need to destroy and recreate.
// https://github.com/terraform-providers/terraform-provider-aws/issues/8431
resource "aws_backup_plan" "backup_plan" {
  count = "${var.use_lifecycle ? 0:1}"
  name  = "${var.plan_name}"

  rule {
    rule_name           = "${var.rule_name}"
    target_vault_name   = "${var.target_vault_name}"
    schedule            = "${var.schedule}"
    start_window        = "${var.start_window}"
    completion_window   = "${var.completion_window}"
    recovery_point_tags = "${var.recovery_point_tags}"
  }

  tags = "${var.plan_tags}"
}

resource "aws_backup_plan" "backup_plan_lifecycle" {
  count = "${var.use_lifecycle ? 1:0}"
  name  = "${var.plan_name}"

  rule {
    rule_name         = "${var.rule_name}"
    target_vault_name = "${var.target_vault_name}"

    lifecycle {
      cold_storage_after = "${var.lifecycle_cold_storage_days}"
      delete_after       = "${var.lifecycle_delete_days}"
    }

    schedule            = "${var.schedule}"
    start_window        = "${var.start_window}"
    completion_window   = "${var.completion_window}"
    recovery_point_tags = "${var.recovery_point_tags}"
  }

  tags = "${var.plan_tags}"
}
