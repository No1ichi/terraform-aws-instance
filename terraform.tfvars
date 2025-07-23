# Main Region for Setup
region = "eu-central-1"
### Domain Name
domain_name = "phantomprotocol.de"
### S3 Bucket Config
s3_bucket_name = "phantomprotocol-bucket"
### VPC Config
vpc_cidr = "10.0.0.0/16"
public_subnets = {
  public_subnet1 = {
    az         = "eu-central-1a"
    cidr_block = "10.0.1.0/24"
  }
  public_subnet2 = {
    az         = "eu-central-1b"
    cidr_block = "10.0.2.0/24"
  }
}
private_subnets = {
  private_subnet1 = {
    az         = "eu-central-1a"
    cidr_block = "10.0.3.0/24"
  }
  private_subnet2 = {
    az         = "eu-central-1b"
    cidr_block = "10.0.4.0/24"
  }
}
vpc_endpoints = {
  s3_endpoint = {
    service_name = "com.amazonaws.eu-central-1.s3"
    type         = "Gateway"
  }
}
###
ssh_access_ip = "188.192.74.171"