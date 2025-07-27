variable "bucket_name" {
  description = "Name of the S3 bucket to be created"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the S3 Bucket"
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

variable "iam_role_name" {
  description = "The Name of the IAM Role"
  type = string
}