data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "all_viewer" {
  name = "Managed-AllViewer"
}  

resource "aws_cloudfront_cache_policy" "videos" {
  name = "video-cache-policy"

  default_ttl = 604800    # 7 Tage
  max_ttl     = 604800
  min_ttl     = 7200      # 2 Stunde

  parameters_in_cache_key_and_forwarded_to_origin {
    headers_config {
      header_behavior = "none"
    }
    cookies_config {
      cookie_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_distribution" "cloudfront" {
    origin {
        domain_name = var.alb_dns_name
        origin_id = var.alb_id

      custom_origin_config {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
       }
    }

    enabled = true
    is_ipv6_enabled = true

    default_cache_behavior {
        target_origin_id = var.alb_id
        viewer_protocol_policy = "redirect-to-https"

        cache_policy_id          = data.aws_cloudfront_cache_policy.caching_optimized.id
        origin_request_policy_id = data.aws_cloudfront_origin_request_policy.all_viewer.id

        allowed_methods  = ["GET","HEAD","OPTIONS","PUT","PATCH","POST","DELETE"]
        cached_methods   = ["GET", "HEAD"]
    }

    ordered_cache_behavior {
      path_pattern = "/images/*"
      target_origin_id = var.alb_id
      viewer_protocol_policy = "redirect-to-https"

      cache_policy_id          = data.aws_cloudfront_cache_policy.caching_optimized.id
      origin_request_policy_id = data.aws_cloudfront_origin_request_policy.all_viewer.id

      allowed_methods  = ["GET","HEAD"]
      cached_methods   = ["GET","HEAD"]
    }

    ordered_cache_behavior {
      path_pattern = "/videos/*"
      target_origin_id = var.alb_id
      viewer_protocol_policy = "redirect-to-https"

      cache_policy_id = aws_cloudfront_cache_policy.videos.id
      origin_request_policy_id = data.aws_cloudfront_origin_request_policy.all_viewer.id
    
      allowed_methods  = ["GET","HEAD"]
      cached_methods   = ["GET","HEAD"]
    }

    restrictions {
        geo_restriction {
          restriction_type = "none"
        }
    }

    viewer_certificate {
        acm_certificate_arn = var.acm_cloudfront_certificate
        ssl_support_method       = "sni-only"
        minimum_protocol_version = "TLSv1.2_2019"
    }

    web_acl_id = var.waf_arn

  tags = {
    Name       = "${var.tags.Name}-cloudfront"
    Owner      = var.tags.Owner
    CostCenter = var.tags.CostCenter
    Project    = var.tags.Project
  }
}