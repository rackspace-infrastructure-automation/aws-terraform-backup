resource "aws_backup_vault" "backup_vault" {
  name = "${var.vault_name}"

  tags = "${var.vault_tags}"

  kms_key_arn = "${var.kms_key_arn}"
}
