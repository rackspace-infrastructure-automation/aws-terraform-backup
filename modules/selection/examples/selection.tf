provider "aws" {
  version = "~> 2.34"
  region  = "us-west-2"
}

# Create a new Selection with an existing Role. For IAM Role details check out https://docs.aws.amazon.com/aws-backup/latest/devguide/access-control.html#managed-policies
module "backup_selection" {
  //  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/selection/?ref=v0.0.1"
  source = "../../../modules/selection"

  # Required
  selection_name = "test_selection"
  plan_id        = "873cf05d-8eb6-4df5-93f6-bf1c88d9785a"

  # Use existing IAM Role.
  create_iam_role = false
  iam_role_arn    = "arn:aws:iam::794790922771:role/role-1rhmmfdv1u-20190618202045176400000001"

  # Create new IAM Role instead of using existing. Newly created Role ARN will be inserted for you.
  //  create_iam_role = true
  //  iam_role_name = "backupRole"

  # Required to have at least one of resources or selection_tag. You can use both fields together as well.
  resources = [
    "arn:aws:dynamodb:region:account-id:table/tablename",
    "arn:aws:ec2:region:account-id:volume/volume-id",
    "arn:aws:elasticfilesystem:region:account-id:file-system/file-system-id",
    "arn:aws:rds:region:account-id:db:db-instance-name",
    "arn:aws:storagegateway:region:account-id:gateway/gateway-id/volume/volume-id",
  ]
  selection_tag = [
    {
      type  = "STRINGEQUALS"
      key   = "backup_it"
      value = "all"
    },
  ]
}
