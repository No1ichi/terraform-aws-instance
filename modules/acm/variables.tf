variable "domain_name" {
  description = "Domain name for the ACM certificate"
  type        = list(string)
  default     = ["phantomprotocol.de", "www.phantomprotocol.de"]
}

variable "region" {
  description = "AWS region where the ACM certificate will be created"
  type        = string
  default     = "us-central-1"
}