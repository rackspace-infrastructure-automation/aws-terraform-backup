variable "plan_name" {
  description = "The display name of a backup plan."
  type        = "string"
}

variable "rule_name" {
  description = "A display name for a backup rule."
  type        = "string"
}

variable "plan_tags" {
  description = "Map of Backup plan tags. i.e. { 'tag_name' = 'tag_value' }"
  type        = "map"
  default     = {}
}

variable "target_vault_name" {
  description = "The name of a logical container where backups are stored."
  type        = "string"
}

variable "schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a backup job. Default is 05:00 UTC every day. Consult https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html for expression help."
  type        = "string"
  default     = "cron(0 5 * * ? *)"
}

variable "start_window" {
  description = "The amount of time in minutes after a backup is scheduled before a job is canceled if it doesn't start successfully. Minimum and Default value is 60. Max is 720 (12 Hours)."
  type        = "string"
  default     = 60
}

variable "completion_window" {
  description = "The amount of time AWS Backup attempts a backup before canceling the job and returning an error. Defaults to 8 hours."
  type        = "string"
  default     = 480
}

variable "lifecycle" {
  description = <<EOF
  Optionally specify lifecycle configuration for the backup. `use_lifecycle` must be `true`.
  cold_storage_after - (Optional) Specifies the number of days after creation that a recovery point is moved to cold storage.
  delete_after (Optional) - Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than cold_storage_after.
  Example:
    lifecycle = {
      cold_storage_after = 10
      delete_after       = 100
    }
  EOF

  type    = "map"
  default = {}
}

variable "use_lifecycle" {
  description = "Lifecycle defines backup expiration and cold storage migration."
  type        = "string"
  default     = false
}

variable "recovery_point_tags" {
  description = "Map of Metadata that you can assign to help organize the resources that you create. i.e. [{key = 'foo', value = 'bar'}]."
  type        = "map"
  default     = {}
}
