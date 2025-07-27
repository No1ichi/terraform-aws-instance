# Create then S3 Read Only Access IAM-Role for EC2 Instances
resource "aws_iam_role" "s3readOnlyAccess_role" {
  name = "s3ReadOnlyAccess_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# The Policy attached to the created IAM-Role
resource "aws_iam_role_policy_attachment" "S3ReadOnlyAccess" {
  role       = aws_iam_role.s3readOnlyAccess_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Wrap it into a profile to connect with EC2 Launch Template
resource "aws_iam_instance_profile" "S3ReadOnlyAccessProfile" {
  name = "S3ReadOnlyAccessProfile"
  role = aws_iam_role.s3readOnlyAccess_role.name
}