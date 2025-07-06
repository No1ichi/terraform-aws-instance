variable subnet_ids {
    description = "List of subnet IDs where the Load Balancer will be deployed"
    type        = list(string)
    default     = [eu-central-1a, eu-central-1b]
}

variable security_group_ids {
    description = "List of security group IDs to associate with the Load Balancer"
    type        = list(string)
    default     = ["sg-12345678", "sg-87654321"]
}

variable "tags" {
  description = "Tags to apply to the VPC and its resources"
  type        = object({
    Name        = string
    Owner       = string
    CostCenter  = string
    Project     = string
  })
  default     = {
    Name        = "pp_alb"
    Owner       = "Bastian"
    CostCenter  = "PP_CostOverview"
    Project     = "IU_CloudProgramming_Project"
  }
}
