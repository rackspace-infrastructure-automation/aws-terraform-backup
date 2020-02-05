# aws-terraform-backup / iam\_default

When controlling an account with Terraform you may not manually intereact with the AWS Backup console. If creating resources via the console the first time you state you want to use the default AWS Backup role it creates it for you. This module replicates that role exactly. Call this once per account and use the name in any AWS Backup selections where the default role is appropriate for your use case.

```HCL
module "backup_iam_role" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/iam_default/?ref=v0.12.0"
}
```

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.34.0 |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| iam\_role\_arn | ARN of the AWS backup role. |
| iam\_role\_name | Name of the AWS backup role. |

