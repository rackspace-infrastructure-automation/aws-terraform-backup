variable "completion_window" {
  description = "The amount of time AWS Backup attempts a backup before canceling the job and returning an error. Defaults to 8 hours. Completion windows only apply to EFS backups."
  type        = "string"
  default     = 480
}

variable "lifecycle" {
  description = <<EOF
    Optionally specify a [lifecycle configuration](https://www.terraform.io/docs/providers/aws/r/backup_plan.html#lifecycle-arguments) map for the backup. `lifecycle_enable` must be `true`.<br>
    **cold_storage_after** - (Optional) Specifies the number of days after creation that a recovery point is moved to cold storage.<br>
    **delete_after** - (Optional) Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than cold_storage_after.<br>
    See [examples](./examples).
EOF

  type    = "map"
  default = {}
}

variable "lifecycle_enable" {
  description = "Set to `true` if an input was provided for variable `lifecycle`."
  type        = "string"
  default     = false
}

variable "plan_name" {
  description = "The display name of the backup plan."
  type        = "string"
}

variable "recovery_point_tags" {
  description = "Map of tags to assign to created recovery points. Note that changes to this variable once set will require the rule to be deleted due to Terraform providers issues [8431](https://github.com/terraform-providers/terraform-provider-aws/issues/8431) and [8737](https://github.com/terraform-providers/terraform-provider-aws/issues/8737)."
  type        = "map"
  default     = {}
}

variable "rule_name" {
  description = "A display name for the backup rule."
  type        = "string"
}

variable "schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a backup job. Default is 05:00 UTC every day. Consult https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html for expression help."
  type        = "string"
  default     = "cron(0 5 ? * * *)"
}

variable "start_window" {
  description = "The amount of time in minutes after a backup is scheduled before a job is canceled if it doesn't start successfully. Minimum and Default value is 60. Max is 720 (12 Hours)."
  type        = "string"
  default     = 60
}

variable "tags" {
  description = "Map of tags to assign to created resources."
  type        = "map"
  default     = {}
}

variable "target_vault_name" {
  description = "The name of the vault to be used for recovery points."
  type        = "string"
}

variable "destination_vault_arn" {
  description = "The arn for the destination vault"
  type        = "string"
}
