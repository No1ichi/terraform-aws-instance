output "certificate_arn" {
  description = "The ARN of the ACM certificate."
  value       = aws_acm_certificate_validation.dns_certificate_validation.certificate_arn
}

output "cf_certificate_arn" {
  description = "The ARN of the ACM certificate for CloudFront."
  value       = aws_acm_certificate_validation.dns_cf_certificate_validation.certificate_arn
}

