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

variable "use_lifecycle" {
  description = "The lifecycle defines when a protected resource is transitioned to cold storage and when it expires. Leave false to not use cold storage."
  type        = "string"
  default     = false
}

variable "lifecycle_cold_storage_days" {
  description = "Specifies the number of days after creation that a recovery point is moved to cold storage. `use_lifecycle` must be `true`."
  type        = "string"
  default     = ""
}

variable "lifecycle_cold_storage_delete_days" {
  description = "Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than lifecycle_cold_storage_days. `use_lifecycle` must be `true`."
  type        = "string"
  default     = ""
}

variable "recovery_point_tags" {
  description = "Map of Metadata that you can assign to help organize the resources that you create. i.e. [{key = 'foo', value = 'bar'}]."
  type        = "map"
  default     = {}
}
