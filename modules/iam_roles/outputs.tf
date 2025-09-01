output "aws_iam_role_name" {
    description = "The Name of the AWS IAM Role"
    value = aws_iam_role.s3readOnlyAccess_role.name
}

output "ec2s3readonlyprofile" {
    description = "The Name of the S3 Read Only Access IAM Instance Profile"
    value = aws_iam_instance_profile.S3ReadOnlyAccessProfile.name
}