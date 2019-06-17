output "plan_arn" {
  description = "Plan ARN."
  value       = "${module.plan.plan_arn}"
}

output "plan_version" {
  description = "Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan."
  value       = "${module.plan.plan_version}"
}

output "selection_id" {
  description = "Backup Selection identifier."
  value       = "${module.selection.selection_id}"
}

output "vault_name" {
  description = "The name of the vault."
  value       = "${module.vault.vault_name}"
}

output "vault_arn" {
  description = "The ARN of the vault."
  value       = "${module.vault.vault_arn}"
}

output "vault_recovery_points" {
  description = "The number of recovery points that are stored in a backup vault."
  value       = "${module.vault.vault_recovery_points}"
}
