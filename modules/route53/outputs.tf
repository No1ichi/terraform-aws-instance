output hosted_zone_id {
    description = "The ID of the created Hosted Zone"
    value = data.aws_route53_zone.hosted_zone.id
}

output "domain_name" {
    description = "The name of the registered domain"
    value = data.aws_route53_zone.hosted_zone.name
}