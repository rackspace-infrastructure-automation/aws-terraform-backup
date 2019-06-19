## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| kms\_key\_arn | The server-side encryption key that is used to protect your backups. | string | `""` | no |
| vault\_name | Name of the backup vault to create. | string | n/a | yes |
| vault\_tags | Map of Metadata that you can assign to help organize the resources that you create. i.e.   {     tag_name_one = "tag_value_one"     tag_name_two = "tag_value_two"   } | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| vault\_arn | The ARN of the vault. |
| vault\_name | The name of the vault. |
| vault\_recovery\_points | The number of recovery points that are stored in a backup vault. |

