# aws-terraform-backup / plan

This module creates an AWS Backup plan used to schedule backups and manage lifecycle of recovery points.

```HCL
module "backup_plan" {
  source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/plan/?ref=v0.12.0"

  lifecycle = {
    delete_after = 35
  }

  lifecycle_enable  = true
  plan_name         = "${local.tags["Environment"]}-Plan"
  rule_name         = "Daily"
  schedule          = "cron(0 5 ? * * *)"
  start_window      = 60
  tags              = "${local.tags}"
  target_vault_name = "${module.backup_vault.vault_name}"
}
```

Due to previous bugs [8431](https://github.com/terraform-providers/terraform-provider-aws/issues/8431) and [8737](https://github.com/terraform-providers/terraform-provider-aws/issues/8737)  
we need to set the minimum aws provider version at 2.34.0

## Terraform 0.12 upgrade

Changes were required while adding terraform 0.12 compatibility.

### Module variables

The following module variable was updated due to requirements for a reserved name:

- `lifecycle` -> `lifecycle_bu`

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.34.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| completion\_window | The amount of time AWS Backup attempts a backup before canceling the job and returning an error. Defaults to 8 hours. Completion windows only apply to EFS backups. | `number` | `480` | no |
| lifecycle\_bu | Optionally specify a [lifecycle configuration](https://www.terraform.io/docs/providers/aws/r/backup_plan.html#lifecycle-arguments) map for the backup. `lifecycle_enable` must be `true`.<br>     **cold\_storage\_after** - (Optional) Specifies the number of days after creation that a recovery point is moved to cold storage.<br>     **delete\_after** - (Optional) Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than cold\_storage\_after.<br>     See [examples](./examples). | `map(string)` | `{}` | no |
| lifecycle\_enable | Set to `true` if an input was provided for variable `lifecycle`. | `string` | `false` | no |
| plan\_name | The display name of the backup plan. | `string` | n/a | yes |
| recovery\_point\_tags | Map of tags to assign to created recovery points. Note that changes to this variable once set will require the rule to be deleted due to Terraform providers issues [8431](https://github.com/terraform-providers/terraform-provider-aws/issues/8431) and [8737](https://github.com/terraform-providers/terraform-provider-aws/issues/8737). | `map(string)` | `{}` | no |
| rule\_name | A display name for the backup rule. | `string` | n/a | yes |
| schedule | A CRON expression specifying when AWS Backup initiates a backup job. Default is 05:00 UTC every day. Consult https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html for expression help. | `string` | `"cron(0 5 ? * * *)"` | no |
| start\_window | The amount of time in minutes after a backup is scheduled before a job is canceled if it doesn't start successfully. Minimum and Default value is 60. Max is 720 (12 Hours). | `number` | `60` | no |
| tags | Map of tags to assign to created resources. | `map(string)` | `{}` | no |
| target\_vault\_name | The name of the vault to be used for recovery points. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| plan\_arn | Plan ARN. |
| plan\_id | Plan ID. |
| plan\_name | Plan name. |
| plan\_version | Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan. |

