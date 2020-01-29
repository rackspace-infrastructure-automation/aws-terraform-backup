variable "create_iam_role" {
  description = "Create a new IAM role that AWS Backup uses to authenticate when backing up the target resource(s) using the default policy, `AWSBackupServiceRolePolicyForBackup`. Setting this to `true` must be accompanied by `iam_role_name`. If this is `false` and both `iam_role_arn` and `iam_role_name` are empty the module will attempt to use the default AWS Backup role, `AWSBackupDefaultServiceRole`."
  type        = string
  default     = false
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

variable "plan_id" {
  description = "The backup plan ID to be associated with the selection of resources."
  type        = string
}

variable "resources" {
  description = "Optional list of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. i.e ['arn:aws:ec2:us-east-1:123456789012:volume/','arn:aws:ec2:us-east-1:56789012234:volume/']"
  type        = list(string)
  default     = []
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


  type    = list(string)
  default = []
}

