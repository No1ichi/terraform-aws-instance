output "certificate_arn" {
  description = "The ARN of the ACM certificate."
  value       = aws_acm_certificate.pp_certificate.arn
}