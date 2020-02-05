provider "aws" {
  version = "~> 2.34"
  region  = "us-west-2"
}

module "backup_vault" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/vault/?ref=v0.12.0"

  tags = {
    tag_name  = "tag_value"
    other_tag = "other_value"
  }

  vault_name = "new_vault_name"
}
