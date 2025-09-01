variable "alb_dns_name" {
    description = "The DNS name of the ALB"
    type = string
}

variable "alb_id" {
  description = "The ID of the ALB"
  type = string
}

variable "waf_arn" {
    description = "The ARN of the WAF"
    type = string
}

variable "acm_cloudfront_certificate" {
    description = "The ACM Certificate for CloudFront Service in US-East-1 Region "
    type = string
}

variable "tags" {
  description = "Tags to apply to the VPC and its resources"
  type = object({
    Name       = string
    Owner      = string
    CostCenter = string
    Project    = string
  })
  default = {
    Name       = "service-name"
    Owner      = "Owner"
    CostCenter = "Cost-Center"
    Project    = "Project-Name"
  }
}

variable "domain_name" {
    description = "Sets the Name for the domain"
    type = string
}