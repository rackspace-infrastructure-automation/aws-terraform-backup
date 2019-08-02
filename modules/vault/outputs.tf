output "vault_arn" {
  description = "The ARN of the vault."
  value       = "${aws_backup_vault.main.arn}"
}

output "vault_name" {
  description = "The name of the vault."
  value       = "${aws_backup_vault.main.id}"
}

output "vault_recovery_points" {
  description = "The number of recovery points that are stored in a backup vault."
  value       = "${aws_backup_vault.main.recovery_points}"
}
