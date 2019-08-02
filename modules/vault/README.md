# # aws-terraform-backup / vault

This module creates an AWS Backup vault used to store backup recovery points.

```HCL
module "backup_vault" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/vault/?ref=v0.0.3"

  tags = {
    Environment = "${var.environment}"
  }

  vault_name = "new_vault_name"
}

[Further examples available.](./examples)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| kms\_key\_arn | Optional server-side KMS encryption key that is used to protect your backups. If this is not provided AWS Backup will use a default aws:kms key for this service. | string | `""` | no |
| tags | Map of tags to assign to created resources. | map | `<map>` | no |
| vault\_name | Name of the backup vault to create. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| vault\_arn | The ARN of the vault. |
| vault\_name | The name of the vault. |
| vault\_recovery\_points | The number of recovery points that are stored in a backup vault. |

