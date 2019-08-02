# aws-terraform-backup / selection

This module creates an AWS Backup selection used to target resources for backup.

```HCL
module "backup_selection" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/selection/?ref=v0.0.3"

  plan_id        = "${module.plan.plan_id}"
  resources      = []
  selection_name = "Tagged"
  selection_tag = [
    {
      type  = "STRINGEQUALS"
      key   = "BackupPlan"
      value = "${module.plan.plan_name}"
    },
  ]
}
```

[Further examples available.](./examples)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_iam\_role | Create a new IAM role that AWS Backup uses to authenticate when backing up the target resource(s) using the default policy, `AWSBackupServiceRolePolicyForBackup`. Setting this to `true` must be accompanied by `iam_role_name`. If this is `false` and both `iam_role_arn` and `iam_role_name` are empty the module will attempt to use the default AWS Backup role, `AWSBackupDefaultServiceRole`. | string | `"false"` | no |
| iam\_role\_arn | Optional, the ARN of an existing IAM role that AWS Backup uses to authenticate when backing up the target resource(s). Must have the appropriate permissions for the target(s) and AWS Backup. | string | `""` | no |
| iam\_role\_name | Optional, the name for the IAM Role to be created if setting `create_iam_role` to `true`. | string | `""` | no |
| plan\_id | The backup plan ID to be associated with the selection of resources. | string | n/a | yes |
| resources | Optional list of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. i.e ['arn:aws:ec2:us-east-1:123456789012:volume/','arn:aws:ec2:us-east-1:56789012234:volume/'] | list | `<list>` | no |
| selection\_name | The display name of the resource selection document. | string | n/a | yes |
| selection\_tag | Optional list of maps used to specify a set of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. Please note that due to Terraform limitations, because `selection_tag` is a block, interpolations inside a given list may result in an error.<br>     **type** - must equal `"STRINGEQUALS"`<br>     **key** - the tag key to match<br>     **value** - the tag value to match<br>     See [examples](./examples). | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| backup\_iam\_role\_arn | ARN for given IAM Role or newly created IAM Role. |
| selection\_id | Backup Selection identifier. |

