variable "domain_name" {
    description = "Sets the Name for the domain"
    type = string
    default = "example.com"
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
        contact_type      = string
        country_code      = string
        email             = string
        first_name        = string
        last_name         = string
        organization_name = string
        phone_number      = string
        state             = string
        zip_code          = string
    })
    default = {
        address_line_1    = "Main Street"
        city              = "City"
        contact_type      = "Company"
        country_code      = "GER"
        email             = "example@email.com"
        first_name        = "Jon"
        last_name         = "Doe"
        organization_name = "Organization"
        phone_number      = "0049 123 456 789"
        state             = "State"
        zip_code          = "987654"
    }
}

variable "registrant_contacts" {
    description = "Sets the registrant contact details for the domain registration"
    type = object({
        address_line_1    = string
        city              = string
        contact_type      = string
        country_code      = string
        email             = string
        first_name        = string
        last_name         = string
        organization_name = string
        phone_number      = string
        state             = string
        zip_code          = string
    })
    default = {
        address_line_1    = "Main Street"
        city              = "City"
        contact_type      = "Company"
        country_code      = "GER"
        email             = "example@email.com"
        first_name        = "Jon"
        last_name         = "Doe"
        organization_name = "Organization"
        phone_number      = "0049 123 456 789"
        state             = "State"
        zip_code          = "987654"
    }
}

variable "tech_contacts" {
    description = "Sets the tech contact details for the domain registration"
    type = object({
        address_line_1    = string
        city              = string
        contact_type      = string
        country_code      = string
        email             = string
        first_name        = string
        last_name         = string
        organization_name = string
        phone_number      = string
        state             = string
        zip_code          = string
    })
    default = {
        address_line_1    = "Main Street"
        city              = "City"
        contact_type      = "Company"
        country_code      = "GER"
        email             = "example@email.com"
        first_name        = "Jon"
        last_name         = "Doe"
        organization_name = "Organization"
        phone_number      = "0049 123 456 789"
        state             = "State"
        zip_code          = "987654"
    }
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

