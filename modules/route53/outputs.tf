output hosted_zone_id {
    description = "The ID of the created Hosted Zone"
    value = aws_route53_zone.hosted_zone.id
}

output "domain_name" {
    description = "The name of the registered domain"
    value = aws_route53domains_domain.domain_name
}