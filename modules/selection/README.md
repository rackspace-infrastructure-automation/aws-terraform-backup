## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create\_iam\_role | Create a new IAM role that AWS Backup uses to authenticate when restoring and backing up the target resource. | string | `"false"` | no |
| iam\_role\_arn | The ARN of the IAM role that AWS Backup uses to authenticate when restoring and backing up the target resource. | string | `""` | no |
| iam\_role\_name | The name of the newly created Backup IAM Role. | string | `""` | no |
| plan\_id | The backup plan ID to be associated with the selection of resources. | string | n/a | yes |
| resources | An list of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. i.e ['arn:aws:ec2:us-east-1:123456789012:volume/','arn:aws:ec2:us-east-1:56789012234:volume/'] | list | `<list>` | no |
| selection\_name | The display name of a resource selection document. | string | n/a | yes |
| selection\_tag | List of Tag-based conditions used to specify a set of resources to assign to a backup plan. Must use `selection_tag` and/or `resources`. i.e.     [{       type = "STRINGEQUALS"       key   = "foo"       value = "bar"     }] | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| selection\_id | Backup Selection identifier. |

