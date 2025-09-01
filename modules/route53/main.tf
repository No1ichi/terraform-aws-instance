# Checks for an already existing hosted zone in Route 53
data "aws_route53_zone" "hosted_zone" {
    name = var.domain_name
    private_zone = false
}

# Creates a record in the hosted zone for root address
resource "aws_route53_record" "root_alias" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = true
  }
}

# Creates a record in the hosted zone for www address
resource "aws_route53_record" "www_alias" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.cloudfront_dns_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = true
  }
}