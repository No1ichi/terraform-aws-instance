output "domain_name" {
  description = "The Domain Name configured in Route53"
  value       = module.route53.domain_name
}

output "hosted_zone_id" {
  description = "The ID of the Route53 Hosted Zone"
  value       = module.route53.hosted_zone_id
}

output "vpc_id" {
  description = "Then ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The List with the IDs of the Public Subnets"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_ids" {
  description = "The List with the IDs of the Private Subnets"
  value       = module.vpc.private_subnet_id
}

output "vpc_cidr_block" {
  description = "The CIDR Block of the created VPC"
  value       = module.vpc.cidr_block
}

output "alb_dns_name" {
  description = "The DNS Name of the created ALB"
  value       = module.load_balancer.alb_name
}

output "asg_name" {
  description = "The Name of the Auto Scaling Group"
  value       = module.auto_scaling_group.asg_name
}

output "s3_name" {
  description = "The Name of the S3 Bucket"
  value       = module.s3.s3_bucket_name
}

output "cloudfront_name" {
  description = "The Name of the CloudFront Application"
  value       = module.cloudfront.cloudfront_name
}

output "waf_name" {
  description = "The Name of the AWS WAF"
  value       = module.waf.waf_name
}