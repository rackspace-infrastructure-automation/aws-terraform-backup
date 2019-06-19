module "backup_role" {
  build_state = "${var.create_iam_role}"
  source      = "git@github.com:rackspace-infrastructure-automation/aws-terraform-iam_resources//modules/role?ref=v0.0.1"
  name        = "${var.iam_role_name}"

  aws_service = ["backup.amazonaws.com"]

  policy_arns       = ["arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"]
  policy_arns_count = 1
}

resource "aws_backup_selection" "backup_selection" {
  iam_role_arn = "${var.create_iam_role ? module.backup_role.arn:var.iam_role_arn}"
  name         = "${var.selection_name}"
  plan_id      = "${var.plan_id}"

  selection_tag = "${var.selection_tag}"

  resources = ["${var.resources}"]
}
