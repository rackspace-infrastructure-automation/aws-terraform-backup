provider "aws" {
  version = "~> 2.14"
  region  = "us-west-2"
}

module "backup" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/backup?ref=v0.0.1"

  # Plan
  plan_name = "newPlanName"
  rule_name = "newRuleName"

  # Selection
  # IAM Role Created
  create_iam_role = true

  iam_role_name = "newRolename"

  # Or using existing IAM Role
  //  create_iam_role = false
  //  iam_role_arn    = "arn:aws:iam::<account>:role/existingrolename-2019061715234345400"

  resources = [
    "arn:aws:dynamodb:us-west-2:<account>:table/<table_name>",
    "arn:aws:elasticfilesystem:us-west-2:<account>:file-system/fs-c9f44862",
    "arn:aws:ec2:us-west-2:<account>:volume/vol-0589bb15c1d311dfa",
  ]
  selection_tag = [
    {
      type  = "STRINGEQUALS"
      key   = "backup_it"
      value = "all"
    },
  ]
  selection_name = "fullSelectionName"
  # Vault
  vault_name = "newVault"
  plan_tags = {
    plan_tag_one = "plan_tag_value_one"
    plan_tag_two = "plan_tag_value_two"
  }
  schedule          = "cron(0 12 * * ? *)"
  start_window      = 240
  completion_window = 600
  # Use Lifecycle Cold Storage
  use_lifecycle = true
  lifecycle = {
    cold_storage_after = 10
    delete_after       = 100
  }
  recovery_point_tags = {
    recovery_tag_name = "recovery_tag_value"
  }
  vault_tags = {
    vault_tag = "vault_tag_value"
  }
  # Using a custom KMS key for encryption
  kms_key_arn = "arn:aws:kms:us-west-2:<account>:key/e267ea23-9d4d-a24e-247bc44f5fae"
}
