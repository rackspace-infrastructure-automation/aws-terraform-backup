output "backup_iam_role_arn" {
  description = "ARN for given IAM Role or newly created IAM Role."
  value       = var.create_iam_role ? module.backup_role.arn : local.default_role
}

output "selection_id" {
  description = "Backup Selection identifier."
  value       = aws_backup_selection.backup_selection.id
}

