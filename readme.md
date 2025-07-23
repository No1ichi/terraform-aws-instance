Wichtig: Das Terraform Script checkt bei Route53 Domain Registration nicht, ob eine Domain verfügbar ist. Das muss vorab zum Beispiel mit dem AWS CLI überprüft werden:
        aws route53domains check-domain-availability --domain-name "deine-wunschdomain.com"



// Es muss noch ein Zertifikat für den Load Balancer erstellt werden in der richtigen Region.

ACM
Connect ACM domain_name = var.domain_name mit Route53
output "domain_name" {
    description = "The name of the registered domain"
    value = aws_route53domains_domain.domain_name
}
Connect zone_id = var.hosted_zone_id mit Route53
output hosted_zone_id {
    description = "The ID of the created Hosted Zone"
    value = aws_route53_zone.hosted_zone.id
}

Connect ASG id = var.launch_template_id mit ec2
output launch_template_id {
    description = "The ID of the launch_template"
    value = aws_launch_template.launch_template.id
}

Auto Scaling Group
Connect ASG vpc_zone_identifier = var.subnet_ids mit VPC 
output "private_subnet_id" {
  description = "The ID of the private subnet"
  value = aws_subnet.private_subnet[*].id
}


