# Setup WAF Web ACL
resource "aws_wafv2_web_acl" "web_acl" {
    name = var.waf_name
    description = "WAF for Website"
    scope = "CLOUDFRONT"

    default_action {
        allow {}
    }

    visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name = "${var.waf_name}-waf"
        sampled_requests_enabled = true
    }

    # AWS Managed Rules - Common Rule Set
    rule {
        name = "AWSManagedRulesCommonRuleSet"
        priority = 1

        override_action {
          none {
          }
        }

        statement {
            managed_rule_group_statement {
                name = "AWSManagedRulesCommonRuleSet"
                vendor_name = "AWS"
            }
        }
        visibility_config {
            cloudwatch_metrics_enabled = true
            sampled_requests_enabled = true
            metric_name = "commonRuleSet"
        }
    }

    # AWS Managed Rules - IP Reputation List
    rule {
        name = "AWSManagedRulesAmazonIpReputationList"
        priority = 2

        override_action {
          none {
          }
        }

        statement {
            managed_rule_group_statement {
                name = "AWSManagedRulesAmazonIpReputationList"
                vendor_name = "AWS"
            }
        }
        visibility_config {
            cloudwatch_metrics_enabled = true
            sampled_requests_enabled = true
            metric_name = "ipReputation"
        }
    }

    # AWS Managed Rules - Known Bad Inputs Rule Set
    rule {
        name = "AWSManagedRulesKnownBadInputsRuleSet"
        priority = 3

        override_action {
          none {
          }
        }

        statement {
            managed_rule_group_statement {
                name = "AWSManagedRulesKnownBadInputsRuleSet"
                vendor_name = "AWS"
            }
        }
        visibility_config {
            cloudwatch_metrics_enabled = true
            sampled_requests_enabled = true
            metric_name = "knownBadInputs"
        }
    }

    # Custom Rule - IP Rate Limit Rule
    rule {
        name = "RateLimitRule"
        priority = 4
        
        action {
            block {}
        }
        statement {
            rate_based_statement {
                limit = 200
                aggregate_key_type = "IP"
            }
        }
        visibility_config {
            cloudwatch_metrics_enabled = true
            sampled_requests_enabled = true
            metric_name = "ipRateLimit"
        }
    }
}