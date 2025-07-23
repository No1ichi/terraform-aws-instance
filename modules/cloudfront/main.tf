resource "aws_cloudfront_distribution" "cloudfront" {
    origin {
        domain_name = var.alb_dns_name
        origin_id = var.alb_id
    }

    enabled = true
    is_ipv6_enabled = true

    default_cache_behavior {
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = var.alb_id
        viewer_protocol_policy = "https-only"
    }

    restrictions {
        geo_restriction {
          restriction_type = "none"
        }
    }

    viewer_certificate {
        acm_certificate_arn = var.acm_cloudfront_certificate
    }

    web_acl_id = var.waf_arn

  tags = {
    Name       = "${var.tags.Name}-cloudfront"
    Owner      = var.tags.Owner
    CostCenter = var.tags.CostCenter
    Project    = var.tags.Project
  }
}