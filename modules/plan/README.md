## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| completion\_window | The amount of time AWS Backup attempts a backup before canceling the job and returning an error. Defaults to 8 hours. | string | `"480"` | no |
| lifecycle\_cold\_storage\_days | Specifies the number of days after creation that a recovery point is moved to cold storage. `use_lifecycle` must be `true`. | string | `""` | no |
| lifecycle\_cold\_storage\_delete\_days | Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than lifecycle_cold_storage_days. `use_lifecycle` must be `true`. | string | `""` | no |
| plan\_name | The display name of a backup plan. | string | n/a | yes |
| plan\_tags | Map of Backup plan tags. i.e. { 'tag_name' = 'tag_value' } | map | `<map>` | no |
| recovery\_point\_tags | Map of Metadata that you can assign to help organize the resources that you create. i.e. [{key = 'foo', value = 'bar'}]. | map | `<map>` | no |
| rule\_name | A display name for a backup rule. | string | n/a | yes |
| schedule | A CRON expression specifying when AWS Backup initiates a backup job. Default is 05:00 UTC every day. Consult https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html for expression help. | string | `"cron(0 5 * * ? *)"` | no |
| start\_window | The amount of time in minutes after a backup is scheduled before a job is canceled if it doesn't start successfully. Minimum and Default value is 60. Max is 720 (12 Hours). | string | `"60"` | no |
| target\_vault\_name | The name of a logical container where backups are stored. | string | n/a | yes |
| use\_lifecycle | The lifecycle defines when a protected resource is transitioned to cold storage and when it expires. Leave false to not use cold storage. | string | `"false"` | no |

## Outputs

| Name | Description |
|------|-------------|
| plan\_arn | Plan ARN. |
| plan\_id | Plan ID |
| plan\_version | Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan. |

