## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| completion\_window | The amount of time AWS Backup attempts a backup before canceling the job and returning an error. Defaults to 8 hours. Completion windows only apply to EFS backups. | string | `"480"` | no |
| create\_iam\_role | Create a new IAM role that AWS Backup uses to authenticate when backing up the target resource(s) using the default policy, `AWSBackupServiceRolePolicyForBackup`. Setting this to `true` must be accompanied by `iam_role_name`. If this is `false` and both `iam_role_arn` and `iam_role_name` are empty the module will attempt to use the default AWS Backup role, `AWSBackupDefaultServiceRole`. | string | `"false"` | no |
| environment | Application environment for which these resources are being created, e.g. Production, Development, etc. | string | `"Development"` | no |
| iam\_role\_arn | Optional, the ARN of an existing IAM role that AWS Backup uses to authenticate when backing up the target resource(s). Must have the appropriate permissions for the target(s) and AWS Backup. | string | `""` | no |
| iam\_role\_name | Optional, the name for the IAM Role to be created if setting `create_iam_role` to `true`. | string | `""` | no |
| kms\_key\_arn | Optional server-side KMS encryption key that is used to protect your backups. If this is not provided AWS Backup will use a default aws:kms key for this service. | string | `""` | no |
| lifecycle | Optionally specify a [lifecycle configuration](https://www.terraform.io/docs/providers/aws/r/backup_plan.html#lifecycle-arguments) map for the backup. `lifecycle_enable` must be `true`.<br>     **cold_storage_after** - (Optional) Specifies the number of days after creation that a recovery point is moved to cold storage.<br>     **delete_after** - (Optional) Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than cold_storage_after.<br>     See [examples](./examples). | map | `<map>` | no |
| lifecycle\_enable | Set to `true` if an input was provided for variable `lifecycle`. | string | `"false"` | no |
| plan\_name | The display name of the backup plan. | string | n/a | yes |
| plan\_tags | Map of tags to assign to created plan. | map | `<map>` | no |
| recovery\_point\_tags | Map of tags to assign to created recovery points. Note that changes to this variable once set will require the rule to be deleted due to Terraform providers issues [8431](https://github.com/terraform-providers/terraform-provider-aws/issues/8431) and [8737](https://github.com/terraform-providers/terraform-provider-aws/issues/8737). | map | `<map>` | no |
| resources | Optional list of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. i.e ['arn:aws:ec2:us-east-1:123456789012:volume/','arn:aws:ec2:us-east-1:56789012234:volume/'] | list | `<list>` | no |
| rule\_name | A display name for the backup rule. | string | n/a | yes |
| schedule | A CRON expression specifying when AWS Backup initiates a backup job. Default is 05:00 UTC every day. Consult https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html for expression help. | string | `"cron(0 5 ? * * *)"` | no |
| selection\_name | The display name of the resource selection document. | string | n/a | yes |
| selection\_tag | Optional list of maps used to specify a set of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. Please note that due to Terraform limitations, because `selection_tag` is a block, interpolations inside a given list may result in an error.<br>     **type** - must equal `"STRINGEQUALS"`<br>     **key** - the tag key to match<br>     **value** - the tag value to match<br>     See [examples](./examples). | list | `<list>` | no |
| start\_window | The amount of time in minutes after a backup is scheduled before a job is canceled if it doesn't start successfully. Minimum and Default value is 60. Max is 720 (12 Hours). | string | `"60"` | no |
| vault\_name | Name of the backup vault to create. | string | n/a | yes |
| vault\_tags | Map of tags to assign to created vault. | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| backup\_iam\_role\_arn | ARN for given IAM Role or newly created IAM Role. |
| plan\_arn | Plan ARN. |
| plan\_id | Plan ID |
| plan\_version | Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan. |
| selection\_id | Backup Selection identifier. |
| vault\_arn | The ARN of the vault. |
| vault\_name | The name of the vault. |
| vault\_recovery\_points | The number of recovery points that are stored in a backup vault. |

