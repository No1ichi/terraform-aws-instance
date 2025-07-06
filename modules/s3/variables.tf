variable "tags" {
  description = "Tags to apply to the S3 Bucket"
  type        = object({
    Name        = string
    Owner       = string
    CostCenter  = string
    Project     = string
  })
  default     = {
    Name        = "phantomprotocol-bucket"
    Owner       = "Bastian"
    CostCenter  = "PP_CostOverview"
    Project     = "IU_CloudProgramming_Project"
  }
}
