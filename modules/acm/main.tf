# Get the certificate from Amazon Certificate Manager (ACM)
resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name       = "${var.tags.Name}-acm"
    Owner      = var.tags.Owner
    CostCenter = var.tags.CostCenter
    Project    = var.tags.Project
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.hosted_zone_id
}

# Validate the certificate using DNS validation
resource "aws_acm_certificate_validation" "dns_certificate_validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_validation : record.fqdn]

  depends_on = [aws_route53_record.certificate_validation]
}




# Get the certificate from Amazon Certificate Manager (ACM) for CloudFront
resource "aws_acm_certificate" "cf_certificate" {
  region            = "us-east-1"
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name       = "acm-cf-${var.tags.Name}"
    Owner      = var.tags.Owner
    CostCenter = var.tags.CostCenter
    Project    = var.tags.Project
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cf_certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cf_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.hosted_zone_id
}

# Validate the certificate using DNS validation
resource "aws_acm_certificate_validation" "dns_cf_certificate_validation" {
  certificate_arn         = aws_acm_certificate.cf_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cf_certificate_validation : record.fqdn]

  depends_on = [aws_route53_record.cf_certificate_validation]
}