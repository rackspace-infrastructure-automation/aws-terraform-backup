# Required
variable "selection_name" {
  description = "The display name of a resource selection document."
  type        = "string"
}

variable "plan_id" {
  description = "The backup plan ID to be associated with the selection of resources."
  type        = "string"
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

variable "resources" {
  description = "An list of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. i.e ['arn:aws:ec2:us-east-1:123456789012:volume/','arn:aws:ec2:us-east-1:56789012234:volume/']"
  type        = "list"
  default     = []
}
