output "cloudfront_name" {
  description = "The Name of the CloudFront Application"
  value = aws_cloudfront_distribution.cloudfront.domain_name
}

output "cloudfront_zone_id" {
  description = "The CloudFront HostedZone ID"
  value = aws_cloudfront_distribution.cloudfront.hosted_zone_id
}