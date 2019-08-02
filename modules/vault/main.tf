/**
 * # # aws-terraform-backup / vault
 *
 * This module creates an AWS Backup vault used to store backup recovery points.
 *
 * ```HCL
 * module "backup_vault" {
 *   source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/vault/?ref=v0.0.3"
 *
 *   tags = {
 *     Environment = "${var.environment}"
 *   }
 *
 *   vault_name = "new_vault_name"
 * }
 *
 * [Further examples available.](./examples)
 */

resource "aws_backup_vault" "main" {
  name        = "${var.vault_name}"
  kms_key_arn = "${var.kms_key_arn}"

  tags = "${var.tags}"
}
