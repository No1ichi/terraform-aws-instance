variable "public_key" {
  description = "The Value of the Public Key"
  type = string
}

variable "launch_template_name" {
  description = "Name for the EC2 instance launch template"
  type = string
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-003c9adf81de74b40"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "iamProfileName" {
  description = "The Name of the S3 Read Only Access IAM Instance Profile"
  type = string
}

variable "security_group_ids" {
  description = "Security group ID to associate with the instance"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the EC2 instance"
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

variable "user_data" {
  description = "User data script to run on instance launch"
  type        = string
  default     = ""
}