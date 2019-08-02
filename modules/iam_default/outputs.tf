output "iam_role_arn" {
  description = "ARN of the AWS backup role."
  value       = "${aws_iam_role.backup_service.arn}"
}

output "iam_role_name" {
  description = "Name of the AWS backup role."
  value       = "${aws_iam_role.backup_service.name}"
}
