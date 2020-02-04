variable "completion_window" {
  description = "The amount of time AWS Backup attempts a backup before canceling the job and returning an error. Defaults to 8 hours. Completion windows only apply to EFS backups."
  type        = number
  default     = 480
}

variable "create_iam_role" {
  description = "Create a new IAM role that AWS Backup uses to authenticate when backing up the target resource(s) using the default policy, `AWSBackupServiceRolePolicyForBackup`. Setting this to `true` must be accompanied by `iam_role_name`. If this is `false` and both `iam_role_arn` and `iam_role_name` are empty the module will attempt to use the default AWS Backup role, `AWSBackupDefaultServiceRole`."
  type        = bool
  default     = false
}

variable "environment" {
  description = "Application environment for which these resources are being created, e.g. Production, Development, etc."
  type        = string
  default     = "Development"
}

variable "iam_role_arn" {
  description = "Optional, the ARN of an existing IAM role that AWS Backup uses to authenticate when backing up the target resource(s). Must have the appropriate permissions for the target(s) and AWS Backup."
  type        = string
  default     = ""
}

variable "iam_role_name" {
  description = "Optional, the name for the IAM Role to be created if setting `create_iam_role` to `true`."
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = "Optional server-side KMS encryption key that is used to protect your backups. If this is not provided AWS Backup will use a default aws:kms key for this service."
  type        = string
  default     = ""
}

variable "lifecycle_bu" {
  description = <<EOF
    Optionally specify a [lifecycle configuration](https://www.terraform.io/docs/providers/aws/r/backup_plan.html#lifecycle-arguments) map for the backup. `lifecycle_enable` must be `true`.<br>
    **cold_storage_after** - (Optional) Specifies the number of days after creation that a recovery point is moved to cold storage.<br>
    **delete_after** - (Optional) Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than cold_storage_after.<br>
    See [examples](./examples).
EOF


  type    = map(string)
  default = {}
}

variable "lifecycle_enable" {
  description = "Set to `true` if an input was provided for variable `lifecycle`."
  type        = bool
  default     = false
}

variable "plan_name" {
  description = "The display name of the backup plan."
  type        = string
}

variable "plan_tags" {
  description = "Map of tags to assign to created plan."
  type        = map(string)
  default     = {}
}

variable "recovery_point_tags" {
  description = "Map of tags to assign to created recovery points. Note that changes to this variable once set will require the rule to be deleted due to Terraform providers issues [8431](https://github.com/terraform-providers/terraform-provider-aws/issues/8431) and [8737](https://github.com/terraform-providers/terraform-provider-aws/issues/8737)."
  type        = map(string)
  default     = {}
}

variable "resources" {
  description = "Optional list of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. i.e ['arn:aws:ec2:us-east-1:123456789012:volume/','arn:aws:ec2:us-east-1:56789012234:volume/']"
  type        = list(string)
  default     = []
}

variable "rule_name" {
  description = "A display name for the backup rule."
  type        = string
}

variable "schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a backup job. Default is 05:00 UTC every day. Consult https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html for expression help."
  type        = string
  default     = "cron(0 5 ? * * *)"
}

variable "selection_name" {
  description = "The display name of the resource selection document."
  type        = string
}

variable "selection_tag" {
  description = <<EOF
    Optional list of maps used to specify a set of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. Please note that due to Terraform limitations, because `selection_tag` is a block, interpolations inside a given list may result in an error.<br>
    **type** - must equal `"STRINGEQUALS"`<br>
    **key** - the tag key to match<br>
    **value** - the tag value to match<br>
    See [examples](./examples).
EOF


  type    = list(map(string))
  default = []
}

variable "start_window" {
  description = "The amount of time in minutes after a backup is scheduled before a job is canceled if it doesn't start successfully. Minimum and Default value is 60. Max is 720 (12 Hours)."
  type        = number
  default     = 60
}

variable "vault_name" {
  description = "Name of the backup vault to create."
  type        = string
}

variable "vault_tags" {
  description = "Map of tags to assign to created vault."

  type    = map(string)
  default = {}
}
