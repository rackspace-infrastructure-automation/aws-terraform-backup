variable "kms_key_arn" {
  description = "Optional server-side KMS encryption key that is used to protect your backups. If this is not provided AWS Backup will use a default aws:kms key for this service."
  type        = "string"
  default     = ""
}

variable "tags" {
  description = "Map of tags to assign to created resources."
  type        = "map"
  default     = {}
}

variable "vault_name" {
  description = "Name of the backup vault to create."
  type        = "string"
}
