resource "aws_subnet" "sprint7_public_subnet01" {
  vpc_id                  = aws_vpc.sprint7_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_prefix}public-subnet01"
  }
}

resource "aws_route_table" "sprint7_public_rt" {
  vpc_id = aws_vpc.sprint7_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sprint7_igw.id
  }

  tags = {
    Name = "${local.name_prefix}public-rt"
  }
}

resource "aws_route_table_association" "sprint7_public_rt_assoc" {
  subnet_id      = aws_subnet.sprint7_public_subnet01.id
  route_table_id = aws_route_table.sprint7_public_rt.id
}