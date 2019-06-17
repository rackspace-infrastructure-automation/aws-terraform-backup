# Required

variable "plan_name" {
  description = "The display name of a backup plan."
  type        = "string"
}

variable "rule_name" {
  description = "A display name for a backup rule."
  type        = "string"
}

variable "selection_name" {
  description = "The display name of a resource selection document."
  type        = "string"
}

variable "vault_name" {
  description = "Name of the backup vault to create."
  type        = "string"
}

variable "resources" {
  description = "An list of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. i.e ['arn:aws:ec2:us-east-1:123456789012:volume/','arn:aws:ec2:us-east-1:56789012234:volume/']"
  type        = "list"
  default     = []
}

variable "selection_tag" {
  description = <<EOF
    List of Tag-based conditions used to specify a set of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. i.e.
    [{
      type = "STRINGEQUALS"
      key   = "foo"
      value = "bar"
    }]
  EOF

  type    = "list"
  default = []
}

# Required IAM Role options

variable "create_iam_role" {
  description = "Create a new IAM role that AWS Backup uses to authenticate when restoring and backing up the target resource."
  type        = "string"
  default     = false
}

variable "iam_role_name" {
  description = "The name of the newly created Backup IAM Role."
  type        = "string"
  default     = ""
}

variable "iam_role_arn" {
  description = "The ARN of the IAM role that AWS Backup uses to authenticate when restoring and backing up the target resource."
  type        = "string"
  default     = ""
}

# Optional

variable "plan_tags" {
  description = "Map of Backup plan tags. i.e. { 'tag_name' = 'tag_value' }"
  type        = "map"
  default     = {}
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
  description = "Map of Metadata that you can assign to help organize the resources that you create. i.e. {tag_name='tag_value'}."
  type        = "map"
  default     = {}
}

variable "vault_tags" {
  description = <<EOF
  Map of Metadata that you can assign to help organize the resources that you create. i.e.
  {
    tag_name_one = "tag_value_one"
    tag_name_two = "tag_value_two"
  }
 EOF

  type    = "map"
  default = {}
}

variable "kms_key_arn" {
  description = "The server-side encryption key that is used to protect your backups."
  type        = "string"
  default     = ""
}
