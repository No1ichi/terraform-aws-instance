output "cloudfront_name" {
  description = "The Name of the CloudFront Application"
  value = aws_cloudfront_distribution.cloudfront.domain_name
}