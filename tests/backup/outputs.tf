output "backup_iam_role_arn" {
  description = "ARN for given IAM Role or newly created IAM Role."
  value       = module.backup_plan.backup_iam_role_arn
}

output "plan_arn" {
  description = "Plan ARN."
  value       = module.backup_plan.plan_arn
}

output "plan_id" {
  description = "Plan ID."
  value       = module.backup_plan.plan_id
}

output "plan_version" {
  description = "Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan."
  value       = module.backup_plan.plan_version
}

output "selection_id" {
  description = "Backup Selection identifier."
  value       = module.backup_plan.selection_id
}

output "vault_name" {
  description = "The name of the vault."
  value       = module.backup_plan.vault_name
}

output "vault_arn" {
  description = "The ARN of the vault."
  value       = module.backup_plan.vault_arn
}

output "vault_recovery_points" {
  description = "The number of recovery points that are stored in a backup vault."
  value       = module.backup_plan.vault_recovery_points
}

