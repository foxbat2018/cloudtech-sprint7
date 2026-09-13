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

resource "aws_route_table" "sprint7_private_rt" {
  vpc_id = aws_vpc.sprint7_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.sprint7_nat.id
  }

  tags = {
    Name = "${local.name_prefix}private-rt"
  }

}

resource "aws_route_table_association" "sprint7_private_rt_assoc01" {
  subnet_id      = aws_subnet.sprint7_private_subnet01.id
  route_table_id = aws_route_table.sprint7_private_rt.id
}

resource "aws_route_table_association" "sprint7_private_rt_assoc02" {
  subnet_id      = aws_subnet.sprint7_private_subnet02.id
  route_table_id = aws_route_table.sprint7_private_rt.id
}
