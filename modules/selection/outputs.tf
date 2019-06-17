output "selection_id" {
  description = "Backup Selection identifier."
  value       = "${aws_backup_selection.backup_selection.id}"
}
