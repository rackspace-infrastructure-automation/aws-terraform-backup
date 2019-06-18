provider "aws" {
  version = "~> 2.14"
  region  = "us-west-2"
}

resource "random_string" "r_string" {
  length = 10
}

module "db" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-dynamo//?ref=v0.0.3"

  attributes = [
    {
      name = "TestHashKey"
      type = "S"
    },
  ]

  environment          = "Test"
  hash_key             = "MyHashKey"
  read_capacity_units  = 5
  table_name           = "${format("table-%s", random_string.r_string.result)}"
  tags                 = { backup_it="all"}
  write_capacity_units = 5
}

module "backup_plan" {
  source = "../../module/modules/backup"

  # Plan
  plan_name = "${format("plan-%s", random_string.r_string.result)}"
  rule_name = "${format("rule-%s", random_string.r_string.result)}"

  # Selection
  # IAM Role Created
  create_iam_role = true

  iam_role_name = "${format("role-%s", random_string.r_string.result)}"

  resources = "${list(format("%s", module.db.table_arn))}"

  selection_tag = [
    {
      type  = "STRINGEQUALS"
      key   = "backup_it"
      value = "all"
    },
  ]

  selection_name = "${format("selection-%s", random_string.r_string.result)}"

  # Vault
  vault_name = "${format("vault-%s", random_string.r_string.result)}"
}
