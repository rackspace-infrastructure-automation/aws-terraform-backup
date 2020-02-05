provider "aws" {
  version = "~> 2.34"
  region  = "us-west-2"
}

locals {
  tags = {
    Environment     = "Test"
    Purpose         = "Testing aws-terraform-backup"
    ServiceProvider = "Rackspace"
    Terraform       = "true"
  }
}

resource "random_string" "identifier" {
  length  = 10
  upper   = false
  special = false
}

module "db" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-dynamo//?ref=master"

  attributes = [
    {
      name = "TestHashKey"
      type = "S"
    },
  ]

  hash_key             = "TestHashKey"
  read_capacity_units  = 5
  name                 = random_string.identifier.result
  tags                 = local.tags
  write_capacity_units = 5
}

module "backup_plan" {
  source = "../../module/modules/backup"

  create_iam_role = true
  iam_role_name   = format("role-%s", random_string.identifier.result)
  plan_name       = format("plan-%s", random_string.identifier.result)
  plan_tags       = local.tags
  resources       = [format("%s", module.db.table_arn)]
  rule_name       = format("rule-%s", random_string.identifier.result)
  selection_name  = format("selection-%s", random_string.identifier.result)

  selection_tag = [
    {
      type  = "STRINGEQUALS"
      key   = "backup_it"
      value = "all"
    },
  ]

  vault_name = format("vault-%s", random_string.identifier.result)
  vault_tags = local.tags
}

module "backup_plan_lifecycle" {
  source = "../../module/modules/backup"

  create_iam_role  = true
  iam_role_name    = format("lifectcle-role-%s", random_string.identifier.result)
  plan_name        = format("plan-%s", random_string.identifier.result)
  plan_tags        = local.tags
  resources        = [format("%s", module.db.table_arn)]
  rule_name        = format("rule-%s", random_string.identifier.result)
  selection_name   = format("selection-%s", random_string.identifier.result)
  lifecycle_enable = true
  lifecycle_bu     = { delete_after = 1 }

  selection_tag = [
    {
      type  = "STRINGEQUALS"
      key   = "backup_it"
      value = "all"
    },
  ]

  vault_name = format("vault_lifecycle-%s", random_string.identifier.result)
  vault_tags = local.tags
}
