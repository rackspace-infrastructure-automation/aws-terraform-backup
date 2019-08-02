output "plan_arn" {
  description = "Plan ARN."
  value       = "${element(coalescelist(aws_backup_plan.main.*.arn, aws_backup_plan.main_with_lifecycle.*.arn), 0)}"
}

output "plan_id" {
  description = "Plan ID."
  value       = "${element(coalescelist(aws_backup_plan.main.*.id, aws_backup_plan.main_with_lifecycle.*.id), 0)}"
}

output "plan_name" {
  description = "Plan name."
  value       = "${element(coalescelist(aws_backup_plan.main.*.name, aws_backup_plan.main_with_lifecycle.*.name), 0)}"
}

output "plan_version" {
  description = "Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan."
  value       = "${element(coalescelist(aws_backup_plan.main.*.version, aws_backup_plan.main_with_lifecycle.*.version), 0)}"
}
