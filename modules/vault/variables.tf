variable "vault_name" {
  description = "Name of the backup vault to create."
  type        = "string"
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
