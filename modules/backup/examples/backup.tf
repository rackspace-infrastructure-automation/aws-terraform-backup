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
  create_iam_role = false
  iam_role_arn    = "arn:aws:iam::<account>:role/existingrolename-2019061715234345400"

  resources = [
    #Dynamo
    "arn:aws:dynamodb:us-west-2:<account>:table/<table_name>",

    # EFS
    "arn:aws:elasticfilesystem:us-west-2:<account>:file-system/fs-c9f44862",

    # EBS
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
}
