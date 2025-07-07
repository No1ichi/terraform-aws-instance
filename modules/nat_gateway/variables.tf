variable "subnet_id" {
  description = "The ID of the subnet where the NAT Gateway will be deployed"
  type        = string
  default     = "aws.subnet.pp_public_subnet[0].id"
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
    Name       = "pp_NAT_Gateway"
    Owner      = "Bastian"
    CostCenter = "PP_CostOverview"
    Project    = "IU_CloudProgramming_Project"
  }
}