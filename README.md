# aws-terraform-backup

This repository contains several terraform modules that can be used to deploy parts or an entire AWS Backup solution, such as AWS Backup Plans, Selections, and Vaults.  It also contains the AWS Backup module to combine all three to create a Vault, Selection and Plan.

## Module listing
- [backup](./modules/backup) - A terraform module that can be used to create a new Vault with a Backup Plan and Selection as well as creating a new IAM Backup Role.
- [plan](./modules/plan) - A terraform module that can be used to create an AWS Backup Plan. Backup Plans enable you to define your backup requirements and then apply them to the AWS resources you want backed up. You can create separate backup plans that meet specific business and regulatory compliance requirements, helping to ensure that each of your AWS resources are backed up and protected.
- [selection](./modules/selection) - A terraform module that can be used to create an AWS Backup Selection. A Selection allows you to "select" resources to be backed up either by ARN or by Tag Matching. You can have multiple Selections in a Plan.
- [vault](./modules/vault) - A terraform module to create an AWS Backup Vault to store backups. A Vault is a container that you organize your backups in. You can use backup vaults to set the AWS Key Management Service (AWS KMS) encryption key that is used to encrypt backups in the backup vault and to control access to the backups in the backup vault. If you require different encryption keys or access policies for different groups of backups, you can optionally create multiple backup vaults. Otherwise, you can have all your backups organized in the default backup vault.

## Other TF Modules Used
- Using [aws-terraform-iam_resources](https://github.com/rackspace-infrastructure-automation/aws-terraform-iam_resources) to create the AWS Backup Role if selected in Selection module.