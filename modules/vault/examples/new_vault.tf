provider "aws" {
  version = "~> 2.14"
  region  = "us-west-2"
}

module "backup_vault" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/vault?ref=v0.0.1"

  vault_name = "new_vault_name"

  vault_tags = {
    tag_name  = "tag_value"
    other_tag = "other_value"
  }

  # add only if you are using a custom KMS key for backup encryption
  kms_key_arn = "arn:aws:kms:us-west-2:<aws_account_number>:key/e267ea23-4494-a24e-247bcffe44f5fae"
}
