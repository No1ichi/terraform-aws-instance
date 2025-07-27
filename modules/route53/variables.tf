variable "domain_name" {
    description = "Sets the Name for the domain"
    type = string
}

variable "auto_renew" {
    description = "Sets the Auto-Renew On or Off. Default is off"
    type = bool
    default = false
}

variable "admin_contacts" {
    description = "Sets the admin contact details for the domain registration"
    type = object({
        address_line_1    = string
        city              = string
        country_code      = string
        email             = string
        first_name        = string
        last_name         = string
        organization_name = string
        phone_number      = string
        state             = string
        zip_code          = string
    })
}

variable "registrant_contacts" {
    description = "Sets the admin contact details for the domain registration"
    type = object({
        address_line_1    = string
        city              = string
        country_code      = string
        email             = string
        first_name        = string
        last_name         = string
        organization_name = string
        phone_number      = string
        state             = string
        zip_code          = string
    })
}

variable "tech_contacts" {
    description = "Sets the admin contact details for the domain registration"
    type = object({
        address_line_1    = string
        city              = string
        country_code      = string
        email             = string
        first_name        = string
        last_name         = string
        organization_name = string
        phone_number      = string
        state             = string
        zip_code          = string
    })
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

variable "alb_dns_name" {
    description = "The ALB Name"
    type = string
}

variable "alb_zone_id" {
    description = "The ALB Zone ID"
    type = string
}

