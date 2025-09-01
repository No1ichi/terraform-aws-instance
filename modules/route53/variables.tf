variable "domain_name" {
    description = "Sets the Name for the domain"
    type = string
}

variable "cloudfront_dns_name" {
    description = "The ALB Name"
    type = string
}

variable "cloudfront_zone_id" {
    description = "The ALB Zone ID"
    type = string
}

