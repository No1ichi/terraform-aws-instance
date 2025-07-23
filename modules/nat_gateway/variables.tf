variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the NAT-Gateway"
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