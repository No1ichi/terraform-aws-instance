# Setup WAF Web ACL
resource "aws_waf2_web_acl" "web_acl" {
    name = var.waf_name
    scope = "CLOUDFRONT"
    description = "WAF for Website"
}