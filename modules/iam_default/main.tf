/**
 * # aws-terraform-backup / iam_default
 *
 * When controlling an account with Terraform you may not manually intereact with the AWS Backup console. If creating resources via the console the first time you state you want to use the default AWS Backup role it creates it for you. This module replicates that role exactly. Call this once per account and use the name in any AWS Backup selections where the default role is appropriate for your use case.
 *
 * ```HCL
 * module "backup_iam_role" {
 *   source = "git@github.com:rackspace-infrastructure-automation/aws-terraform-backup//modules/iam_default/?ref=v0.0.3"
 * }
 * ```
 */

data "aws_iam_policy_document" "backup_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "backup_service" {
  name               = "AWSBackupDefaultServiceRole"
  description        = "Provides AWS Backup permission to create backups and perform restores on your behalf across AWS services."
  path               = "/service-role/"
  assume_role_policy = "${data.aws_iam_policy_document.backup_assume.json}"
}

resource "aws_iam_role_policy_attachment" "backup" {
  role       = "${aws_iam_role.backup_service.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "restore" {
  role       = "${aws_iam_role.backup_service.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}
