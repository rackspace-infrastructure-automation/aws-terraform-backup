/**
 * # # aws-terraform-backup / vault
 *
 * This module creates an AWS Backup vault used to store backup recovery points.
 *
 * ```HCL
 * module "backup_vault" {
 *   source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/vault/?ref=v0.12.0"
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

terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = ">= 2.34.0"
  }
}

resource "aws_backup_vault" "backup_vault" {
  name        = var.vault_name
  kms_key_arn = var.kms_key_arn

  tags = var.tags
}
