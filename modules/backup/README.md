## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| completion\_window | The amount of time AWS Backup attempts a backup before canceling the job and returning an error. Defaults to 8 hours. | string | `"480"` | no |
| create\_iam\_role | Create a new IAM role that AWS Backup uses to authenticate when restoring and backing up the target resource. | string | `"false"` | no |
| iam\_role\_arn | The ARN of the IAM role that AWS Backup uses to authenticate when restoring and backing up the target resource. | string | `""` | no |
| iam\_role\_name | The name of the newly created Backup IAM Role. | string | `""` | no |
| kms\_key\_arn | The server-side encryption key that is used to protect your backups. | string | `""` | no |
| lifecycle\_cold\_storage\_days | Specifies the number of days after creation that a recovery point is moved to cold storage. `use_lifecycle` must be `true`. | string | `""` | no |
| lifecycle\_cold\_storage\_delete\_days | Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than lifecycle_cold_storage_days. `use_lifecycle` must be `true`. | string | `""` | no |
| plan\_name | The display name of a backup plan. | string | n/a | yes |
| plan\_tags | Map of Backup plan tags. i.e. { 'tag_name' = 'tag_value' } | map | `<map>` | no |
| recovery\_point\_tags | Map of Metadata that you can assign to help organize the resources that you create. i.e. {tag_name='tag_value'}. | map | `<map>` | no |
| resources | An list of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. i.e ['arn:aws:ec2:us-east-1:123456789012:volume/','arn:aws:ec2:us-east-1:56789012234:volume/'] | list | `<list>` | no |
| rule\_name | A display name for a backup rule. | string | n/a | yes |
| schedule | A CRON expression specifying when AWS Backup initiates a backup job. Default is 05:00 UTC every day. Consult https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html for expression help. | string | `"cron(0 5 * * ? *)"` | no |
| selection\_name | The display name of a resource selection document. | string | n/a | yes |
| selection\_tag | List of Tag-based conditions used to specify a set of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. i.e.     [{       type = "STRINGEQUALS"       key   = "foo"       value = "bar"     }] | list | `<list>` | no |
| start\_window | The amount of time in minutes after a backup is scheduled before a job is canceled if it doesn't start successfully. Minimum and Default value is 60. Max is 720 (12 Hours). | string | `"60"` | no |
| use\_lifecycle | The lifecycle defines when a protected resource is transitioned to cold storage and when it expires. Leave false to not use cold storage. | string | `"false"` | no |
| vault\_name | Name of the backup vault to create. | string | n/a | yes |
| vault\_tags | Map of Metadata that you can assign to help organize the resources that you create. i.e.   {     tag_name_one = "tag_value_one"     tag_name_two = "tag_value_two"   } | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| plan\_arn | Plan ARN. |
| plan\_id | Plan ID |
| plan\_version | Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan. |
| selection\_id | Backup Selection identifier. |
| vault\_arn | The ARN of the vault. |
| vault\_name | The name of the vault. |
| vault\_recovery\_points | The number of recovery points that are stored in a backup vault. |

