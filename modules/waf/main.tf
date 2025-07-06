# Setup WAF Web ACL
resource "aws_waf2_web_acl" "pp_web_acl" {
    name = "phantomprotocol_WAF"
    scope = "CLOUDFRONT"
    description = "WAF for Phantom Protocol"
    "
}"