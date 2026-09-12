resource "aws_internet_gateway" "sprint7_igw" {
  vpc_id = aws_vpc.sprint7_vpc.id

  tags = {
    Name = "${local.name_prefix}-igw"
  }
}