output "plan_arn" {
  description = "Plan ARN."
  value = element(
    coalescelist(
      aws_backup_plan.backup_plan.*.arn,
      aws_backup_plan.backup_plan_lifecycle.*.arn,
    ),
    0,
  )
}

output "plan_id" {
  description = "Plan ID."
  value = element(
    coalescelist(
      aws_backup_plan.backup_plan.*.id,
      aws_backup_plan.backup_plan_lifecycle.*.id,
    ),
    0,
  )
}

output "plan_name" {
  description = "Plan name."
  value = element(
    coalescelist(
      aws_backup_plan.backup_plan.*.name,
      aws_backup_plan.backup_plan_lifecycle.*.name,
    ),
    0,
  )
}

output "plan_version" {
  description = "Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan."
  value = element(
    coalescelist(
      aws_backup_plan.backup_plan.*.version,
      aws_backup_plan.backup_plan_lifecycle.*.version,
    ),
    0,
  )
}

