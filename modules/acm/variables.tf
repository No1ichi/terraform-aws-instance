variable "domain_name" {
  description = "Domain name for the ACM certificate"
  type        = string
}

variable "hosted_zone_id" {
  description = "The Route 53 hosted zone ID for DNS Validation"
  type = string
}

variable "tags" {
  description = "Tags to apply to the registered Domain"
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