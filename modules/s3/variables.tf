variable "bucket_name" {
  description = "Name of the S3 bucket to be created"
  type        = string
  default     = "phantomprotocol-bucket"
}

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
