output "waf_id" {
  description = "The ID of the WAF"
  value = aws_wafv2_web_acl.web_acl.id
}

output "waf_arn" {
    description = "The ARN of the WAF"
    value = aws_wafv2_web_acl.web_acl.arn
}