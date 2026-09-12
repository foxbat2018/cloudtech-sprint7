provider "aws" {
  region = "ap-northeast-1"
}

locals {
  app_name    = "sprint7"
  name_prefix = "${local.app_name}-"
}

# VPC
resource "aws_vpc" "sprint7_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.name_prefix}vpc"
  }
}
