variable "subnet_id" {
  description = "The ID of the subnet where the NAT Gateway will be deployed"
  type        = string
  default     = "aws.subnet.public_subnet[0].id"
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