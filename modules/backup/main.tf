/*
* # aws-terraform-backup/modules/backup
* This submodule creates an entire AWS Backup Config with a Vault, Plan, Selection and IAM Role
*
* ## Basic Example
* ```
* module "backup" {
*   source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/backup?ref=v0.0.1"
*
* # Plan
*   plan_name = "newPlanName"
*   rule_name = "newRuleName"
*
*   # Selection
*   # IAM Role Created
*   create_iam_role = true
*
*   iam_role_name = "newRolename"
*
*   # Or using existing IAM Role
*   create_iam_role = false
*   iam_role_arn    = "arn:aws:iam::<account>:role/existingrolename-2019061715234345400"
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
*   selection_tag = [
*     {
*       type  = "STRINGEQUALS"
*       key   = "backup_it"
*       value = "all"
*     },
*   ]
*
*   selection_name = "fullSelectionName"
*
*   # Vault
*   vault_name = "newVault"
* }
* ```
*
* Full working references are available at [examples](examples)
*/

module "plan" {
  source = "../plan"

  # Required
  plan_name         = "${var.plan_name}"
  rule_name         = "${var.rule_name}"
  target_vault_name = "${module.vault.vault_name}"

  #Optional
  schedule                           = "${var.schedule}"
  start_window                       = "${var.start_window}"
  completion_window                  = "${var.completion_window}"
  use_lifecycle                      = "${var.use_lifecycle}"
  lifecycle_cold_storage_days        = "${var.lifecycle_cold_storage_days}"
  lifecycle_cold_storage_delete_days = "${var.lifecycle_delete_days}"
  plan_tags                          = "${var.plan_tags}"
  recovery_point_tags                = "${var.recovery_point_tags}"
}

module "selection" {
  source = "../selection"

  # Required
  create_iam_role = "${var.create_iam_role}"
  iam_role_arn    = "${var.iam_role_arn}"
  iam_role_name   = "${var.iam_role_name}"
  plan_id         = "${module.plan.plan_id}"
  selection_name  = "${var.selection_name}"
  resources       = "${var.resources}"
  selection_tag   = "${var.selection_tag}"
}

module "vault" {
  source = "../vault"

  # Required
  vault_name = "${var.vault_name}"

  # Optional
  kms_key_arn = "${var.kms_key_arn}"
  vault_tags  = "${var.vault_tags}"
}
