provider "aws" {
  version = "~> 2.14"
  region  = "us-west-2"
}

# Create a new Selection with an existing Role. For IAM Role details check out https://docs.aws.amazon.com/aws-backup/latest/devguide/access-control.html#managed-policies
module "backup_selection" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/selection?ref=v0.0.1"

  # Required
  selection_name = "test_selection"
  plan_id        = "13d733b7-4192-4cd2-83c2-90b6b394a395"

  # Use existing IAM Role.
  create_iam_role = false
  iam_role_arn    = "arn:aws:iam::<aws_account_number>:role/existing-backup-role"

  # Create new IAM Role instead of using existing. Newly created Role ARN will be inserted for you.
  //  create_iam_role = true
  //  iam_role_name = "backupRole"

  # Required to have at least one of resources or selection_tag. You can use both fields together as well.
  resources = [
    "arn:aws:dynamodb:us-west-2:<aws_account_number>:table/dynamo_table",
  ]
  selection_tag = [
    {
      type  = "STRINGEQUALS"
      key   = "backup_it"
      value = "all"
    },
  ]
}
