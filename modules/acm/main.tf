# Get the certificate from Amazon Certificate Manager (ACM)
resource "aws_acm_certificate" "pp_certificate" {
  domain_name       = [for domain in var.domain_name : domain]
  validation_method = "DNS"

  tags = {
    Name       = "PP Certificate"
    Owner      = var.tags.Owner
    CostCenter = var.tags.CostCenter
    Project    = var.tags.Project
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "pp_zone" {
  name         = [for domain in var.domain_name : domain]
  private_zone = false
}

resource "aws_route53_record" "pp_certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.pp_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = 60
  zone_id         = data.aws_route53_zone.pp_zone.zone_id
}

# Validate the certificate using DNS validation
resource "aws_acm_certificate_validation" "pp_certificate_validation" {
  certificate_arn         = aws_acm_certificate.pp_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.pp_certificate_validation : record.fqdn]

  depends_on = [aws_route53_record.pp_certificate_validation]
}