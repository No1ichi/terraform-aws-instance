#Define the AWS Launch Template for the EC2 instance
resource "aws_launch_template" "pp_launchTemplate" {
  name_prefix   = "pp_website"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = var.security_group_ids

  user_data = base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name       = var.tags.Name
      Owner      = var.tags.Owner
      CostCenter = var.tags.CostCenter
      Project    = var.tags.Project
    }
  }
}