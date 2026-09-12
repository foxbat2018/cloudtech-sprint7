resource "aws_subnet" "sprint7_private_subnet01" {
  vpc_id                  = aws_vpc.sprint7_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "${local.name_prefix}private-subnet01"
  }
}

resource "aws_subnet" "sprint7_private_subnet02" {
  vpc_id                  = aws_vpc.sprint7_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "${local.name_prefix}private-subnet02"
  }
}