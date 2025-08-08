output "s3_bucket_id" {
    description = "The ID of the S3 bucket"
    value = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_name" {
  description = "The Name of the S3 Bucket"
  value = aws_s3_bucket.s3_bucket.bucket
}