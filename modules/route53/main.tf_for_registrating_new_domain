#Registers a domain on AWS Route 53. Availabilty of domain must be checked before
resource "aws_route53domains_domain" "domain_name" {
    domain_name = var.domain_name
    auto_renew = var.auto_renew

  admin_contact {
    address_line_1    = var.admin_contacts.address_line_1
    city              = var.admin_contacts.city
    country_code      = var.admin_contacts.country_code
    email             = var.admin_contacts.email
    first_name        = var.admin_contacts.first_name
    last_name         = var.admin_contacts.last_name
    organization_name = var.admin_contacts.organization_name
    phone_number      = var.admin_contacts.phone_number
    state             = var.admin_contacts.state
    zip_code          = var.admin_contacts.zip_code
  }

    registrant_contact {
    address_line_1    = var.registrant_contacts.address_line_1
    city              = var.registrant_contacts.city
    country_code      = var.registrant_contacts.country_code
    email             = var.registrant_contacts.email
    first_name        = var.registrant_contacts.first_name
    last_name         = var.registrant_contacts.last_name
    organization_name = var.registrant_contacts.organization_name
    phone_number      = var.registrant_contacts.phone_number
    state             = var.registrant_contacts.state
    zip_code          = var.registrant_contacts.zip_code
  }

    tech_contact {
    address_line_1    = var.tech_contacts.address_line_1
    city              = var.tech_contacts.city
    country_code      = var.tech_contacts.country_code
    email             = var.tech_contacts.email
    first_name        = var.tech_contacts.first_name
    last_name         = var.tech_contacts.last_name
    organization_name = var.tech_contacts.organization_name
    phone_number      = var.tech_contacts.phone_number
    state             = var.tech_contacts.state
    zip_code          = var.tech_contacts.zip_code
  }

  tags = {
    Name       = "${var.tags.Name}-domain_name"
    Owner      = var.tags.Owner
    CostCenter = var.tags.CostCenter
    Project    = var.tags.Project
  }
}

# Creates a hosted zone in Route 53
resource "aws_route53_zone" "hosted_zone" {
    name = var.domain_name
}

# Creates a record in the hosted zone for root address
resource "aws_route53_record" "root_alias" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# Creates a record in the hosted zone for www address
resource "aws_route53_record" "www_alias" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}