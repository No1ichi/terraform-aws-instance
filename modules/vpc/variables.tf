variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnets with Availability Zone and CIDR block"
  type = map(object({
    az         = string
    cidr_block = string
  }))
  default = {
    # Public Subnet 1
    public_subnet1 = {
      az         = "eu-central-1a"
      cidr_block = "10.0.1.0/24"
    }
    # Public Subnet 2
    public_subnet2 = {
      az         = "eu-central-1b"
      cidr_block = "10.0.2.0/24"
    }
  }
}

variable "private_subnets" {
  description = "Map of private subnets with Availability Zone and CIDR block"
  type = map(object({
    az         = string
    cidr_block = string
  }))
  default = {
    # Private Subnet 1
    private_subnet1 = {
      az         = "eu-central-1a"
      cidr_block = "10.0.3.0/24"
    }
    # Private Subnet 2
    private_subnet2 = {
      az         = "eu-central-1b"
      cidr_block = "10.0.4.0/24"
    }
  }
}

variable "vpc_endpoints" {
  description = "VPC endpoint with service name and type"
  type = map(object({
    service_name = string
    type         = string
  }))
  default = {
    # VPC Endpoint for S3
    s3_endpoint = {
      service_name = "com.amazonaws.eu-central-1.s3"
      type         = "Gateway"
    }
  }
}

variable "tags" {
  description = "Tags to apply to the VPC and its resources"
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

variable "nat_gateway_id" {
  description = "The ID of the created NAT-Gateway"
  type = string
}

variable "security_group_ids" {
  description = "Security group ID to associate with the instance"
  type        = list(string)
}

