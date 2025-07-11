output hosted_zone_id {
    description = "The ID of the created Hosted Zone"
    value = aws_route53_zone.hosted_zone.id
}