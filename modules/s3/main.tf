# Setup the S3 Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  tags = {
    Name       = "${var.tags.Name}-s3"
    Owner      = var.tags.Owner
    CostCenter = var.tags.CostCenter
    Project    = var.tags.Project
  }
}

# Block public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "s3_public_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [aws_s3_bucket.s3_bucket]
}

# S3 Bucket Policy to set the bucket connection policy
resource "aws_s3_bucket_policy" "ec2readonly" {
  bucket = aws_s3_bucket.s3_bucket.bucket
    policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.iam_role_name}"
        },
        "Action": [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        "Resource": [
          "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*"
        ]
      }
    ]
  })
}

data "aws_caller_identity" "current" {}

# Load index.html and logo.png into the created S3 bucket
locals {
  site_dir = "${path.root}/website"
  site_files = fileset (local.site_dir, "**")
  mime = {
    html = "text/html"
    png = "image/png"
  }
}

resource "aws_s3_object" "website_html" {
  bucket = var.bucket_name
  key = "mywebsite/index.html"
  source = "${path.root}/website/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "website_png" {
  bucket = var.bucket_name
  key = "mywebsite/logo.png"
  source = "${path.root}/website/images/logo.png"
  content_type = "image/png"
}